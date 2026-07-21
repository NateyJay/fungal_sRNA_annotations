
import sys
from pprint import pprint
from pathlib import Path
import pysam

from collections import Counter

out_file = Path("02out-gc_bias.txt")

found_projects = set()
if out_file.is_file():
	with open(out_file, 'r') as f:
		for line in f:
			line = line.strip().split()
			project = line[0]
			found_projects.add(project)
else:
	with open(out_file, 'w') as outf:
		print("project","size","gc","count", sep='\t', file=outf)

annotation_dir = Path("/Volumes/fungal_srnas/Annotations/")

if not annotation_dir.is_dir():
	sys.exit("annotation directory not found:", annotation_dir)

for bam in annotation_dir.glob("*/align/alignment.bam"):
	gc_c   = Counter()
	print(bam)

	project = bam.parts[-3]
	if project in found_projects:
		print("  already done, skipping...")
		continue




	bamf = pysam.AlignmentFile(bam, "rb")

	for read in bamf.fetch():

		if read.is_mapped:
			# print(read.query_sequence)

			gc_content = int(round((read.query_sequence.count("G") + read.query_sequence.count("C") ) / read.query_length, 2) * 100)
			gc_c[(read.query_length, gc_content)] += 1

	with open(out_file, 'a') as outf:
		for size in range(12, 50):
			for perc in range(0, 101):
				if gc_c[(size, perc)] > 0:
					print(project, size, perc, gc_c[(size, perc)], sep='\t', file=outf)

	# pprint(gc_c)

