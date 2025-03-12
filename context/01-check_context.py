





import sys
from pprint import pprint
from pathlib import Path
import itertools
import pysam
from subprocess import Popen, PIPE
from collections import Counter


meta_annotations = list(Path('../metaloci').glob("*.meta.gff3"))

gene_annotations = list(Path('../+genomes/').glob("*genomic.gff"))
gene_annotation_d = {}
for g in gene_annotations:
	abbv = g.name[:5]

	gene_annotation_d[abbv] = g

rfam_annotations = list(Path('../rfam/02out-rfam_gffs').glob("*.rfam.gff3"))
rfam_annotation_d = {}
for g in rfam_annotations:
	abbv = g.name[:5]

	rfam_annotation_d[abbv] = g


gff_dir = Path("01out-gffs")
gff_dir.mkdir(parents=True, exist_ok=True)

inter_dir = Path("01out-intersections")
inter_dir.mkdir(parents=True, exist_ok=True)



intergenic_distance = 1000

for ann_file in meta_annotations:

	print(ann_file)
	abbv = ann_file.name[:5]

	try:
		gene_annotation_file = gene_annotation_d[abbv]

	except KeyError:
		print("   ^^^ gene_annotation_file not found")
		continue

	try:
		rfam_annotation_file = rfam_annotation_d[abbv]

	except KeyError:
		print("   ^^^ rfam_annotation_file not found")
		continue



	c = Counter()
	c_ft = Counter()
	with open(gene_annotation_file, 'r') as f:
		for line in f:
			if line.startswith("#"):
				continue

			line = line.strip().split()
			c[line[1]] += 1
			c_ft[line[2]] += 1


	main_source = c.most_common(1)[0][0]

	if main_source in ['RefSeq', 'Genbank']:
		selected_features = ['mRNA']

	elif main_source == 'EMBL':
		selected_features = ['gene']



	def parse_attributes(x):
		if x == '.':
			return(None)
		d = {}
		x = x.strip().split(";")
		for xx in x:
			key, val = xx.split("=")
			d[key] = val
		return(d)

	def sort():
		temp_file = Path("temp_sort.gff3")
		call = ['bedtools', 'sort', '-i', gene_annotation_file]

		print("input gff not sorted - sorting now with:")
		print(" ".join(map(str,call)))

		with open(temp_file, 'w') as outf:
			p = Popen(call, stdout=outf)
			p.wait()

		temp_file.rename(gene_annotation_file)


	def combine_annotations():
		comb_file = Path(gff_dir, f"{abbv}.all.gff3")
		# rfam_file = Path(gff_dir, f'{abbv}.rfam.gff3')


		# if not mRNA_file.is_file():# or not exon_file.is_file() or not cds_file.is_file():
		# 	sort()


		def write_file(outf, af, keys):
			lines_written = 0

			with open(af, 'r') as f:
				for line in f:
					if line.startswith("#"):
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
			write_file(outf, gene_annotation_file, selected_features)
			write_file(outf, rfam_annotation_file, ['rRNA', 'tRNA', 'spliceosomal'])

		with open(comb_file, 'w') as outf:
			print("##gff-version 3", file=outf)
			p = Popen(f'bedtools sort -i {temp_file}', shell=True, stdout=outf)
			p.wait()

		temp_file.unlink()


		
		return(comb_file)

	comb_file = combine_annotations()


	def closest(file):

		closest_d = {}

		call= ['bedtools', 'closest', '-a', ann_file, '-b', file, '-d']

		print(" ".join(map(str,call)))
		p = Popen(call, stdout=PIPE, stderr=PIPE, encoding='utf-8')
		out, err = p.communicate()


		for o in out.strip().split("\n"):

			o = o.strip().split("\t")


			s_strand = o[6]
			sa = parse_attributes(o[8])


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
	# print("   mRNAs")
	comb_d = closest(comb_file)
	# print("   exons")
	# exon_d = intersect(exon_file, ID='exon')
	# print("   CDSs")
	# cds_d = intersect(cds_file, ID='cds')


	output_file = Path(inter_dir, f"{abbv}.context.txt")

	print()
	print(f'Printing to...\n  {output_file}')

	with open(output_file, 'w') as outf:
		print("\t".join(['cluster','transcript', 'id', 'type', 'distance', 
			# 'exon_id', 'exon_overlap', 'cds_id', 'cds_overlap', 
			's_strand','m_strand','match','category']), file=outf)

		with open(ann_file, 'r') as f:

			for line in f:

				if line.startswith("#"):
					continue

				line = line.strip().split("\t")

				cluster = line[8].split(";")[0].split("=")[1]

				# print(cluster)

				try:
					m_d = comb_d[cluster]
				except KeyError:
					m_d = {}


				# 	i_d = exon_d[cluster]
				# except KeyError:
				# 	i_d = {}

				# try:
				# 	c_d = cds_d[cluster]
				# except KeyError:
				# 	c_d = {}



				# m_d.update(i_d)
				# m_d.update(c_d)
				d = m_d


				out_line = [cluster]
				for k in ['transcript', 'id', 'type', 'distance',
				 # 'exon_id', 'exon_overlap', 'cds_id', 'cds_overlap', 
				 's_strand','m_strand','match']:

					try:
						out_line.append(d[k])
					except KeyError:
						d[k]= ''
						out_line.append("")


				feature_type = d['type']


				## finding gene relationship

				try:
					if d['distance'] > intergenic_distance:
						gene_relationship = 'intergenic'

					elif 0 < d['distance'] <= intergenic_distance:
						gene_relationship = f'near-genic'

					elif d['distance'] == 0:
						gene_relationship = feature_type

					else:
						# pprint(d)
						sys.exit('gene relationship error')
				except TypeError:
					gene_relationship="intergenic"



				## finding strand relationship

				if gene_relationship != feature_type:
					stranding = "NA"

				elif d['match'] == '=':
					stranding = 'sense'
					gene_relationship = f"{stranding}_{feature_type}"

				elif d['match'] == '!':
					stranding = 'antisense'
					gene_relationship = f"{stranding}_{feature_type}"

				elif d['match'] == '?':
					stranding = 'unstranded'
					gene_relationship = f"{stranding}_{feature_type}"

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




				out_line.append(gene_relationship)



				# print(out_line)
				out_line = '\t'.join(map(str, out_line))
				# sys.exit()

				# print(out_line, sep='\t')
				print(out_line, sep='\t', file=outf)







