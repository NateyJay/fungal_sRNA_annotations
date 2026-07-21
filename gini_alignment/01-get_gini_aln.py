
import pysam
from collections import Counter
import sys
from pprintpp import pprint
from pathlib import Path
import numpy as np
from bisect import bisect







out_dir = Path("01out-ginis")
out_dir.mkdir(exist_ok=True, parents=True)

q_dir = Path("01out-ginis_quantiles")
q_dir.mkdir(exist_ok=True, parents=True)

def calc_bins(bam_file, bin_size=500):

	print()
	print(f"bam_file: {bam_file}")

	try:
		project = bam_file.parts[-3]
	except IndexError:
		project = 'test'
		print("Warning: project name could not be derived from path")
	print(f"project: {project}")
	bamf = pysam.AlignmentFile(bam_file, "rb")
	cd = dict()
	size_d = dict()
	bin_c  = Counter()

	last_ref = None

	header = bamf.header.to_dict()
	sequences = {i['SN'] : i["LN"] for i in header['SQ']}
	libraries = [i["ID"] for i in header['RG']]

	print()
	print("sequences:")
	pprint(sequences)
	print()
	print('libraries:')
	pprint(libraries)



	quantile_file = Path(q_dir, f"{project}.gini_q.txt")
	quantile_temp = quantile_file.with_suffix('.temp.txt')

	if quantile_file.is_file():
		print("all expected_files found. Skipping...")
		return



	for library in libraries:
		total_bins = 0
		cd[library] = Counter()
		for ref, length in sequences.items():
			for r in range(length // bin_size):
				cd[library][(ref, r)] = 0

				total_bins += 1
		cd[library][("*","*")] = 0

	print()
	print(f"bin_size: {bin_size}")
	print(f"total genomic bins: {total_bins:,}")

	print()
	print("quantifying...")

	for read in bamf.fetch():
		ref = read.reference_name
		if last_ref != ref:
			print("  ", ref)
			# if last_ref:
			# 	break
		last_ref = ref

		library  = read.get_tag('RG')
		size     = read.query_length
		bin_name = int(read.reference_start) // bin_size

		key = (ref, bin_name)

		try:
			size_d[key][size] += 1
		except KeyError:
			size_d[key] = Counter()
			size_d[key][size] += 1

		bin_c[key] += 1
		cd[library][key] += 1

	print()
	print("run-length encoding...")

	for library in cd.keys():
		print("  ", library)

		out_file = Path(out_dir, f"{library}.gini.txt")
		temp_file = out_file.with_suffix(".temp.txt")

		rle_d = Counter()
		for k in cd[library].keys():
			if k[0] != "*":
				rle_d[cd[library][k]] += 1


		with open(temp_file, 'w') as outf:
			print(f"# library: {library}", file=outf)
			print(f"# project: {project}", file=outf)
			print("bin_count", 'depth', file=outf, sep='\t')
			for depth, run_length in rle_d.items():
				print(run_length, depth, file=outf, sep='\t')

		temp_file.rename(out_file)


	bin_depths = list(bin_c.values())

	if len(bin_depths) == 0:
		print("ERROR: no bin depths detected! killing...")
		return
	qs = [r/1000 for r in range(0,1001,1)]

	threshold_depths = np.quantile(bin_depths, qs)

	quantile_d = dict()
	for key, depth in bin_c.items():
		i = bisect(threshold_depths, depth)
		# print(i)
		q = qs[i-1]

		try:
			quantile_d[q].update(size_d[key])
		except KeyError:
			quantile_d[q] = Counter()
			quantile_d[q].update(size_d[key])

	quantiles = list(quantile_d.keys())
	quantiles.sort()


	with open(quantile_temp, 'w') as outf:
		print("quantile", "size", "depth", sep='\t', file=outf)


		for q in quantiles:
			for s in range(15, 36):
				d = quantile_d[q][s]
				print(q, s, d, sep='\t', file=outf)

	quantile_temp.rename(quantile_file)



annotation_dir = Path("/Volumes/fungal_srnas/Annotations")

bam_files = [bam_file for bam_file in annotation_dir.glob("*/align/alignment.bam")]
# bam_files = [Path('alignment.bam')]


for i, bam_file in enumerate(bam_files):
	print()
	print("##########################")
	print(f"{i+1}/{len(bam_files)}", bam_file)
	calc_bins(bam_file)

# calc_bins("/Volumes/fungal_srnas/Annotations/Bocin.PRJNA752615/align/alignment.bam")