
from pathlib import Path
import sys
from pprint import pprint
import pysam
from collections import deque, Counter
import json
import gzip




pa = 'Bocin.PRJNA253747'
abbv    = 'Bocin'

out_dir = Path("01out-details")
out_dir.mkdir(parents=True, exist_ok=True)

force = False


def get_dirs():


	gen_dir = Path('/Volumes/fungal_srnas/Genomes/')
	ann_dir = Path('/Volumes/fungal_srnas/Annotations/')

	if ann_dir.is_dir() and gen_dir.is_dir():
		return({'ann':ann_dir, 'gen':gen_dir})

	ann_dir = Path('/Users/jax/fungal_annotations/annotations/')
	gen_dir = Path('/Users/jax/fungal_annotations/Genomes/')

	if ann_dir.is_dir() and gen_dir.is_dir():
		return({'ann':ann_dir, 'gen':gen_dir})

	sys.exit("DIRS NOT FOUND!!!")

dirs = get_dirs()


def process_gff_line(line):
	e1 = dict(zip(['seqid','source','type','start','end','score','strand','phase','attributes'], line[:8]))
	e1['start'], e1['end'] = int(e1['start']), int(e1['end'])
	e2 = dict([tuple(i.split('=')) for i in line[8].split(';')])
	entry = e1 | e2
	return(entry)

def get_gff_list(abbv):
	try:
		gffs = {
				'rfam' : Path(f"../rfam/02out-rfam_gffs/{abbv}.rfam.gff3"),
				"te"   : Path(f"../TE_annotations/eg_out/{abbv}_EarlGrey/{abbv}_summaryFiles/{abbv}.filteredRepeats.gff"),
				'ncbi' : list(dirs['gen'].glob(f"{abbv}*_genomic.gff3"))[0]
				}
	except IndexError:
		return

	banned_te = set(['Simple_repeat', 'Unknown'])

	out_d     = {}
	exon_dict = {}
	done_mRNAs = set()

	print('  loading gffs...')
	for source, gff_file in gffs.items():
		print("   ", gff_file)

		if not gff_file.is_file():
			return

		with open(gff_file, 'r') as f:
			for line in f:
				if line.startswith("#"):
					continue

				line = line.strip().split("\t")
				entry = process_gff_line(line)

				if source == 'te' and entry['type'] in banned_te:
					continue

				elif source == 'ncbi':

					if entry['type'] == 'exon':
						try:
							exon_dict[entry['Parent']].append(entry)
						except KeyError:
							exon_dict[entry['Parent']] = [entry]
						continue

					elif entry['type'] != 'mRNA':
						continue

					elif entry['Parent'] in done_mRNAs:
						continue

					done_mRNAs.add(entry['Parent'])


				if source == 'te':
					entry['name'] = entry['type']

				elif source == 'rfam':
					entry['name'] = entry['ID']

				elif source == 'ncbi':
					entry['name'] = entry['Parent']

				entry['locus'] = f"{entry['seqid']}:{entry['start']}-{entry['end']}"

				try:
					out_d[entry['seqid']].append(entry)
				except KeyError:
					out_d[entry['seqid']] = [entry]

	for seqid in out_d.keys():
		out_d[seqid].sort(key=lambda x: x['start'])
		out_d[seqid] = deque(out_d[seqid])


	return(out_d, exon_dict)



projects = []

with open("../+Figures/00-processed_tables/project.txt", 'r' ) as f:
	header = f.readline().strip().split("\t")

	for line in f:
		line = line.strip().split("\t")

		d = dict(zip(header, line))

		if d['f_pass'] == 'TRUE':
			projects.append(d['project'])


# pa = 'Bocin.PRJNA282704.C'
# projects = ['Cocin.PRJNA477255']



lookup_d = dict() 
with open("../+Figures/00-lookup_table.txt", 'r') as f:
	header = f.readline().strip().split("\t")

	for line in f:
		line = line.strip().split("\t")

		d = dict(zip(header, line))

		if d['refseqAccession'] != "NA":
			lookup_d[d['refseqAccession']] = d['genbankAccession']

		lookup_d[d['genbankAccession']] = d['refseqAccession']



def dict_to_table(d, names):
	out = dict()

	for k,v in d.items():

		e = list(k) + [v]

		for i,n in enumerate(names):
			try:
				out[n].append(e[i])
			except KeyError:
				out[n] = []

	return(out)



def get_conditions():
	out_d = dict()
	with open("../+Figures/00-processed_tables/libraries.txt", 'r') as f:
		header = f.readline().strip().split("\t")

		for line in f:
			line = line.strip().split("\t")

			d = dict(zip(header, line))

			project = d['abbv'] + '.' + d['bioproject']
			cond    = d['rg']
			srr     = d['srr']

			if project not in out_d:
				out_d[project] = {}

			out_d[project][srr] = cond
	return out_d

condition_all_d = get_conditions()


force = False

for project in projects:
	print()
	print(project)
	abbv = project[:5]



	size_json = Path(out_dir, f"{project}.sizes.json.gz")
	bias_json = Path(out_dir, f"{project}.bias.json.gz")
	pos_json  = Path(out_dir, f"{project}.pos.json.gz")

	if size_json.is_file() and pos_json.is_file() and bias_json.is_file() and not force:
		print("  -> already done...")
		continue

	gffs = get_gff_list(abbv)

	if not gffs:
		print("   ❌ failed to find one or more gffs")
		continue

	ann_d, exon_d = gffs



	condition_d = condition_all_d[project]



	class locusClass():
		def __init__(self, entry):
			self.entry  = entry
			self.locus  = entry['locus']
			self.strand = entry['strand']
			self.source = entry['source']


			if entry['type'] == 'mRNA':
				self.name   = entry['name']
			else:
				self.name = entry['name'] + ';' + entry['locus']

			self.pos_c = None

			if entry['type'] == 'mRNA':
				exons = exon_d[entry['ID']]
				self.exon_positions = []
				for exon in exons:
					self.exon_positions += list(range(exon['start'], exon['end']+1))
				self.exon_positions.sort(reverse = entry['strand'] == "-")
				self.exon_length = len(self.exon_positions)

				self.pos_c = Counter()

			self.bias_c = Counter()
			self.size_c = Counter()

		def __repr__(self):
			return(f"{self.entry['ID']} -> {self.entry['seqid']}:{self.entry['start']}-{self.entry['end']}")


		def add(self, read):

			if read.reference_start + read.query_length < self.entry['start']:
				return 'early'

			if read.reference_start > self.entry['end'] or read.reference_name != self.entry['seqid']:
				return 'dead'


			strand  = "+" if read.is_forward else "-"
			try:
				condition = condition_d[read.get_tag("RG")]
			except KeyError:
				return

			if self.entry['type'] == 'mRNA':
				cpos    = read.reference_start + int(read.query_length/2)
				in_exon = cpos in self.exon_positions
				sizing  = "typical" if 19 <= read.query_length <=25 else "other"

				if in_exon:
					fpos = self.exon_positions.index(cpos)
					rpos = len(self.exon_positions) - fpos
				else:
					fpos = "NA"
					rpos = "NA"

				self.pos_c[(strand, cpos, condition, sizing, in_exon, fpos, rpos)] += 1

			self.size_c[(strand, condition, read.query_length)] += 1
			self.bias_c[(strand, condition, read.query_sequence[0])] += 1

		# def cash(self):
		# 	print()
		# 	print('entry:')
		# 	pprint(self.entry)
		# 	print()
		# 	print('sizes:')
		# 	pprint(self.size_c)
		# 	print()
		# 	print("positions:")
		# 	pprint(self.pos_c)


	bam_file = Path(dirs['ann'], project, "align/alignment.bam")

	buffer = deque()


	out_size_d  = {}
	out_bias_d  = {}
	out_count_d = {}

	print(f"  reading bamfile: {bam_file}")

	with pysam.AlignmentFile(bam_file, "rb") as bamf:
		header = bamf.header.to_dict()
		contigs = [entry['SN'] for entry in header['SQ']]



		ld = {k:v for k,v in lookup_d.items() if v in contigs}

		def check_contigs():

			for seqid in ann_d.keys():

				if seqid not in contigs:
					print(seqid)
					return False

			return True


		if not check_contigs:
			print("contigs:")
			pprint(contigs)
			print("locus seqids:")
			pprint(list(ann_d.keys()))

			print("   ❌ failed to find a seqid among alignment contigs!")


			continue

		for ri, read in enumerate(bamf.fetch()):

			if ri % 1000000 == 0:
				print("", ri, read.reference_name, sep='\t')


			if not read.is_mapped:
				continue


			## adding new loci to the buffer when it is empty, or the last locus is right-ward of the current alignment ('early')
			## the last locus of the buffer should always be "early"
			while True:
				
				if len(buffer) > 0 and buffer[-1].add(read) == 'early':
					break

				try:
					to_append = ann_d[read.reference_name].popleft()
				except IndexError:
					break
				except KeyError:
					break

				buffer.append(locusClass(to_append))

			## adding reads to each locus, and noting which are left-ward of the current alignment "dead""
			to_remove = []
			for i,b in enumerate(buffer):
				if b.add(read) == 'dead':
					to_remove.append(i)

			## removing dead loci and aggregating their details to the output dictionaries
			for r in to_remove[::-1]:
				if buffer[r].pos_c:
					out_count_d[buffer[r].name] = {
					'locus'       : buffer[r].locus,
					'strand'      : buffer[r].strand,
					'exon_length' : buffer[r].exon_length,
					'table' : dict_to_table(buffer[r].pos_c, ['strand','position','condition', 'sizing','exon','fpos','rpos','depth'])
					}

				out_size_d[buffer[r].name]  = {
					'source'      : buffer[r].source,
					'locus'       : buffer[r].locus,
					'strand'      : buffer[r].strand,
					'table' : dict_to_table(buffer[r].size_c, ['strand','condition','size','depth'])}

				out_bias_d[buffer[r].name]  = {
					'source'      : buffer[r].source,
					'locus'       : buffer[r].locus,
					'strand'      : buffer[r].strand,
					'table' : dict_to_table(buffer[r].bias_c, ['strand','condition','fivep','depth'])}


				del buffer[r]





	with gzip.open(size_json, 'wt', encoding='UTF-8') as f:
		json.dump(out_size_d, f, indent=4)

	with gzip.open(bias_json, 'wt', encoding='UTF-8') as f:
		json.dump(out_bias_d, f, indent=4)

	with gzip.open(pos_json, 'wt', encoding='UTF-8') as f:
		json.dump(out_count_d, f, indent=4)







