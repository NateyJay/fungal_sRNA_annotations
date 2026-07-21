
import sys
from pprint import pprint
from pathlib import Path
import pysam

from collections import Counter



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

annotation_dir = dirs['ann']


library_to_condition = {}
with open("../+Figures/00-processed_tables/libraries.txt") as f:

	header = f.readline().strip().split('\t')

	for line in f:
		line = line.strip().split('\t')

		d = dict(zip(header, line))

		library_to_condition[d['srr']] = d['rg']


out_file  = Path("01out-5p_bias.txt")

found_projects = set()
if out_file.is_file():
	with open(out_file, 'r') as f:
		for line in f:
			line = line.strip().split()
			project = line[0]
			found_projects.add(project)
else:
	with open(out_file, 'w') as outf:
		print("project", 'cond',"size","fivep","count", sep='\t', file=outf)


if not annotation_dir.is_dir():
	sys.exit("annotation directory not found:", annotation_dir)

for bam in annotation_dir.glob("*/align/alignment.bam"):
	five_c = Counter()
	gc_c   = Counter()
	print(bam)

	project = bam.parts[-3]
	if project in found_projects:
		print("  already done, skipping...")
		continue


	abbv = project[:5]
	if abbv in ['Gimar', 'Focan']:
		continue


	conditions = set()

	bamf = pysam.AlignmentFile(bam, "rb")

	for read in bamf.fetch():

		if read.is_mapped:
			# print(read.query_sequence)
			seq = read.query_sequence[0]
			fivep = seq[0]
			try:
				cond = library_to_condition[read.get_tag("RG")]
			except KeyError:
				continue
			conditions.add(cond)

			five_c[(cond, read.query_length, fivep)] += 1

			
			# gc_content = int(round((read.query_sequence.count("G") + read.query_sequence.count("C") ) / read.query_length, 2) * 100)
			# gc_c[(read.query_length, gc_content)] += 1

	with open(out_file, 'a') as outf:
		for size in range(12, 50):
			# print()
			for base in ["A",'T','G','C']:
				print(project, cond, size, base, five_c[(cond, size, base)], sep='\t', file=outf)

	# pprint(gc_c)

