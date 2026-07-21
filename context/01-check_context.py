





import sys
from pprint import pprint
from pathlib import Path
import itertools
import pysam
from subprocess import Popen, PIPE
from collections import Counter


## listing compiled metalocus annotation files
meta_annotations = list(Path('../metaloci/01out-meta_gffs/').glob("*.meta.gff3"))

## listing compiled gene annotation files
gene_annotations = list(Path('../+genomes/').glob("*genomic.gff3"))
gene_annotation_d = {}
for g in gene_annotations:
	abbv = g.name[:5]

	gene_annotation_d[abbv] = g

## listing compiled structural RNA annotation files
rfam_annotations = list(Path('../rfam/02out-rfam_gffs').glob("*.rfam.gff3"))
rfam_annotation_d = {}
for g in rfam_annotations:
	abbv = g.name[:5]

	rfam_annotation_d[abbv] = g

## making and formatting output directories
gff_dir = Path("01out-gffs")
gff_dir.mkdir(parents=True, exist_ok=True)

inter_dir = Path("01out-intersections")
inter_dir.mkdir(parents=True, exist_ok=True)


## constants
intergenic_distance = 1000


## iterating through each metalocus annotation
for ann_file in meta_annotations:

	print(ann_file)
	abbv = ann_file.name[:5]

	## checking for supporting annotations. These are required to perform context.
	try:
		gene_annotation_file = gene_annotation_d[abbv]
		print(gene_annotation_file)

	except KeyError:
		print("   ^^^ gene_annotation_file not found")
		continue

	try:
		rfam_annotation_file = rfam_annotation_d[abbv]

	except KeyError:
		print("   ^^^ rfam_annotation_file not found")
		continue


	## some basic counters to quantify inputs from  the annotations
	## chromosomes -> c and features -> c_ft

	c = Counter()
	c_ft = Counter()
	with open(gene_annotation_file, 'r') as f:
		for line in f:
			if line.startswith("#"):
				continue

			line = line.strip().split()
			c[line[1]] += 1
			c_ft[line[2]] += 1


	## this code helps to identify what is the best annotative source to use for the gene annotation. EMBL and NCBI have different features which describe mRNAs.
	main_source = c.most_common(1)[0][0]

	if main_source in ['RefSeq', 'Genbank']:
		selected_features = ['mRNA']

	elif main_source == 'EMBL':
		selected_features = ['gene']



	def parse_attributes(x):
		'''takes attribues field of gff and returns as a dictionary'''
		if x == '.':
			return(None)
		d = {}
		x = x.strip().split(";")
		for xx in x:
			key, val = xx.split("=")
			d[key] = val
		return(d)

	def sort():
		'''helper function to sort the temp gff with bedtools'''
		temp_file = Path("temp_sort.gff3")
		call = ['bedtools', 'sort', '-i', gene_annotation_file]

		print("input gff not sorted - sorting now with:")
		print(" ".join(map(str,call)))

		with open(temp_file, 'w') as outf:
			p = Popen(call, stdout=outf)
			p.wait()

		temp_file.rename(gene_annotation_file)


	def get_contig_order():
		order_file = Path(gff_dir, f"{abbv}.order.txt")
		with open(order_file, 'w') as outf:
			with open(ann_file, 'r') as f:
				for line in f:
					if line.startswith("##sequence-region"):
						print(line.split()[1], file=outf)

	get_contig_order()


	def combine_annotations():
		'''function to open rfam and gene anotations, merge them, and return as single sorted output'''

		order_file = Path(gff_dir, f"{abbv}.order.txt")
		comb_file = Path(gff_dir, f"{abbv}.all.gff3")

		def write_file(outf, af, keys, keep_header = False):
			lines_written = 0

			with open(af, 'r') as f:
				for line in f:
					if line.startswith("#"):
						if keep_header:
							print(line.strip(), file=outf)
						continue

					line = line.strip().split('\t')


					if line[2] in keys:

						if line[2] == 'gene':
							line[2] = 'mRNA'

						print("\t".join(line), file=outf)

						# lines_written += 1
						# print(lines_written)

				# if lines_written < 100:
				# 	print(f"WARNING: less than 100 lines written for {file} in the {key} sub-annotation. Is this a fully annotated NCBI-derived GFF3?")

		temp_file = Path("temp.gff3")
		with open(temp_file, 'w') as outf:
			write_file(outf, gene_annotation_file, selected_features, keep_header=True)
			write_file(outf, rfam_annotation_file, ['rRNA', 'tRNA', 'spliceosomal'])


		with open(comb_file, 'w') as outf:
			p = Popen(f'bedtools sort -i {temp_file} -g {str(order_file)}', shell=True, stdout=outf)
			p.wait()
		temp_file.unlink()


		
		return(comb_file)


	## combines and sorts gene and rfam annotation files
	comb_file = combine_annotations()


	def closest(file):
		'''wrapper for bedtools closest, returning stranding and key attributes as a dict'''

		## output is a dictionary of attributes keyed to the names of the metaloci
		closest_d = {}

		call= ['bedtools', 'closest', '-a', ann_file, '-b', file, '-D', 'b', '-t', 'all']

		print(" ".join(map(str,call)))
		p = Popen(call, stdout=PIPE, stderr=PIPE, encoding='utf-8')
		out, err = p.communicate()


		for o in out.strip().split("\n"):

			o = o.strip().split("\t")

			# print(o)
			s_strand = o[6]
			sa = parse_attributes(o[8])


			if sa['ID'] in closest_d:
				d = {}
				d['id'] = "NA"
				d['type'] = "NA"
				d['distance'] = "NA"
				d['orientation'] = "NA"
				d['s_strand'] = s_strand
				d['m_strand'] = "NA"
				d['match'] = "multiple"
				closest_d[sa['ID']] = d
				continue

			try:
				m_strand = o[15]

			except IndexError:
				# print("Warning: `ID` not found in gene annotation")
				closest_d[sa['ID']] = {'error':"no gene in chrom"}
				continue

			ma = parse_attributes(o[17])

			# mRNA_id\ttranscript\tdistance

			d = {}

			try:
				d['id'] = ma['ID']

			except TypeError:
				# print("Warning: `ID` not found in gene annotation")
				closest_d[sa['ID']] = {'error':"no gene in chrom"}
				continue


			feature_type = o[11]

			d['type'] = feature_type
			d['distance'] = int(o[-1])

			if abs(d['distance']) > intergenic_distance:
				d['orientation'] = 'NA'
			elif d['distance'] == 0:
				d['orientation'] = 'NA'
			elif d['distance'] < 0:
				d['orientation'] = 'upstream'
			elif d['distance'] > 0:
				d['orientation'] = 'downstream'

			d['distance'] = abs(d['distance'])

			if s_strand == '.' or m_strand == '.':
				match = "?"
			elif s_strand == m_strand:
				match = "="
			else:
				match = '!'

			d['s_strand'] = s_strand
			d['m_strand'] = m_strand

			d['match'] = match

			closest_d[sa['ID']] = d



		return(closest_d)

	def intersect(file, ID):
		'''wrapper for bedtools intersect, returning stranding and key attributes as a dict'''

		inter_d = {}

		call = ['bedtools', 'intersect', '-a', ann_file, '-b', file, '-wao', '-f', '0.1']


		p = Popen(call, stdout=PIPE, stderr=PIPE, encoding='utf-8')
		out, err = p.communicate()
		# print(out)
		# sys.exit()

		for o in out.strip().split("\n"):
			o = o.strip().split("\t")
			# print(o)
			# print(o[8])
			# print(o[17])
			overlap = int(o[-1])
			sa = parse_attributes(o[8])
			ma = parse_attributes(o[17])


			if ma:
				d = {}

				# feature_type = o[11]
				# if feature_type == 'mRNA':
				# 	feature_type = 'gene'

				# # d['type'] = feature_type

				d[f'{ID}_id'] = ma['ID']
				d[f'{ID}_overlap'] = int(o[-1])

				inter_d[sa['ID']] = d



			# sys.exit()
		return(inter_d)


	print("Finding intersections for...")

	## just performs the "closest" analysis. Intersect was removed in this iteration (though the function remains)
	comb_d = closest(comb_file)



	output_file = Path(inter_dir, f"{abbv}.context.txt")

	print()
	print(f'Printing to...\n  {output_file}')

	## opening files and writing header to output
	outf       = open(output_file, 'w')
	metalocusf = open(ann_file, 'r')

	print("\t".join(['metalocus', 'id', 's_type', 'distance', 
		# 'exon_id', 'exon_overlap', 'cds_id', 'cds_overlap', 
		's_strand','m_strand','match','relationship', 'type', "stranding"]), file=outf)

	## iterating through each metalocus and looking for interactions in comb_d dictionary
	for line in metalocusf:

		if line.startswith("#"):
			continue

		line = line.strip().split("\t")

		## this is the metalocus name
		s_type  = line[2]
		cluster = line[8].split(";")[0].split("=")[1]

		# print(cluster)

		## assigning m_d (mrna_dictionary) from the closest analysis
		try:
			m_d = comb_d[cluster]
		except KeyError:
			m_d = {}



		out_line = [cluster]
		for k in ['transcript', 'id', 'type', 'distance',
		 's_strand','m_strand','match', 'orientation']:

			try:
				m_d[k]
			except KeyError:
				m_d[k]= ''



		## gathering attributes from closes output where available


		## finding gene relationship (does this overlap or come near to a gene?)

		try:
			if m_d['distance'] > intergenic_distance:
				gene_relationship = 'intergenic'
				feature_type = 'NA'

			elif 0 < m_d['distance'] <= intergenic_distance:
				gene_relationship = f"near_{m_d['orientation']}"
				feature_type = m_d['type']

			elif m_d['distance'] == 0:
				gene_relationship = 'intersect'
				feature_type = m_d['type']


			else:
				# pprint(d)
				sys.exit('gene relationship error')

		except TypeError:
			## catches when there are no annotated genes on a chromosome (there is no closest)
			gene_relationship="intergenic"
			feature_type = "NA"


		## finding strand relationship

		if gene_relationship == 'intergenic':
			stranding = "NA"

		elif m_d['match'] == '=':
			stranding = 'sense'

		elif m_d['match'] == '!':
			stranding = 'antisense'

		elif m_d['match'] == '?':
			stranding = 'unstranded'

		else:
			# pprint(d)
			sys.exit('stranding error')


		## finding intragene context

		# if gene_relationship != 'genic':
		# 	intragene_context = "NA"

		# elif d['exon_overlap'] == '':
		# 	intragene_context = 'intronic'

		# elif d['exon_overlap'] > 0 and d['cds_overlap'] == '':
		# 	intragene_context = 'exon-UTR'

		# elif d['exon_overlap'] > 0 and d['cds_overlap'] > 0:
		# 	intragene_context = 'exon-CDS'

		# else:
		# 	# pprint(d)
		# 	sys.exit('intragene_context error')



		# if gene_relationship != 'genic':
		# 	category = gene_relationship

		# else:
		# 	category = f"{stranding}_{feature_type}"



		out_line = [
			cluster,
			m_d['id'],
			s_type,
			m_d['distance'],
			m_d['s_strand'],
			m_d['m_strand'], 
			m_d['match']
		]

		out_line.append(gene_relationship)
		out_line.append(feature_type)
		out_line.append(stranding)



		# print(out_line)
		out_line = '\t'.join(map(str, out_line))
		# sys.exit()

		# print(out_line, sep='\t')
		print(out_line, sep='\t', file=outf)

		# print(out_line, sep='\t')
		# input()

	outf.close()
	metalocusf.close()





