
import pysam
from collections import Counter
import sys
from pprintpp import pprint
from pathlib import Path
import numpy as np
from bisect import bisect




last_out_dir = Path("01out-ginis")
out_dir = Path("02out-size_ginis")
out_dir.mkdir(exist_ok=True, parents=True)


def get_thresholds(libraries):

	qs = [r/1000 for r in range(0,1001,1)]
	d = dict()

	print()
	print("getting thresholds...")
	for library in libraries:
		out_file = Path(last_out_dir, f"{library}.gini.txt")
		print("  ", out_file)
		bin_depths = []

		with open(out_file, 'r') as f:
			f.readline()
			f.readline()
			f.readline()

			for line in f:
				line = line.strip().split()
				count, depth = [int(l) for l in line]

				bin_depths += [depth] * count




			# d = dict()
			ls = list()
			for i,t in enumerate(np.quantile(bin_depths, qs)):
				# d[qs[i]] = int(t)
				ls.append(int(t))
			d[library] = ls

	return(qs, d)



def calc_bins(bam_file, bin_size=500):


	print(f"bam_file: {bam_file}")

	project = bam_file.parts[-3]
	print(f"project: {project}")


	bamf = pysam.AlignmentFile(bam_file, "rb")
	cd = dict()
	rd = dict()

	last_ref = None

	header = bamf.header.to_dict()
	sequences = {i['SN'] : i["LN"] for i in header['SQ']}
	libraries = [i["ID"] for i in header['RG']]

	threshold_qs, thresholds = get_thresholds(libraries)


	if Path(out_dir, f"{project}.gini_size.txt").is_file():
		print("all expected_files found. Skipping...")
		return


	print()
	print("sequences:")
	pprint(sequences)
	print()
	print('libraries:')
	pprint(libraries)

	print()
	print("sizing...")
	c = Counter()

	blank_bin_d = dict()
	for l in libraries:
		blank_bin_d[l] = Counter()
	bin_d = blank_bin_d
	last_bin_name = None

	last_ref = None

	for read in bamf.fetch():


		bin_name = (read.reference_name, read.reference_start // bin_size)


		if read.reference_name != last_ref:
			if last_ref:
				print("  ",read.reference_name)


		last_ref = read.reference_name


		if last_bin_name and bin_name != last_bin_name:

			for library, size_c in bin_d.items():
				total = sum(size_c.values())
				# print(total)
				i = bisect(thresholds[library], total) - 1
				# print(i)
				q = threshold_qs[i]
				# print(q)

				for size, depth in size_c.items():
					c[(library, q, size)] += depth

			bin_d = blank_bin_d

		last_bin_name = bin_name


		library = read.get_tag('RG')
		size    = read.query_length

		bin_d[library][size] += 1


	print()
	print("writing to file...")

	out_file = Path(out_dir, f"{project}.gini_size.txt")
	temp_file = out_file.with_suffix(".temp.txt")

	with open(temp_file, 'w') as outf:
		print('library','quantile','size','depth', file=outf, sep='\t')

		for key, value in c.items():
			library, quantile, size = key
			print(library, quantile, size, value, file=outf, sep='\t')

	temp_file.rename(out_file)




annotation_dir = Path("/Volumes/fungal_srnas/Annotations")

bam_files = [bam_file for bam_file in annotation_dir.glob("*/align/alignment.bam")]

# bam_files = [Path('/Volumes/fungal_srnas/Annotations/Agbis.PRJNA770841/align/alignment.bam')]

for i, bam_file in enumerate(bam_files):
	print()
	print("##########################")
	print(f"{i+1}/{len(bam_files)}", bam_file)
	calc_bins(bam_file)

# calc_bins("/Volumes/fungal_srnas/Annotations/Bocin.PRJNA752615/align/alignment.bam")