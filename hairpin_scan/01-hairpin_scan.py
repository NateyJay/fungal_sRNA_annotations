
import sys
from pprint import pprint
from pathlib import Path
import itertools
import pysam
from subprocess import Popen, PIPE
from collections import deque, Counter



meta_annotations = list(Path('../metaloci',"01out-meta_gffs").glob("*.meta.gff3"))

genomes = list(Path('../+genomes').glob("*genomic.fa"))
genome_d = {}
for g in genomes:
	abbv = g.name[:5]

	genome_d[abbv] = g



def complement(s, dna=True, reverse=True):
	d = {"U":"A", 
	"A":"U", "G":"C", "C":"G", "N":"N"}

	if dna:
		d['T'] = 'A'
		d['A'] = 'T'
		del d['U']


	if reverse:
		s = s[::-1]

	try:
		s = "".join([d[letter] for letter in s])
	except KeyError:
		print(f"Warning: sequence {s} ommitted. Did you select the correct DNA or RNA mode?")
		return(False)
	return(s)




# 1 import metaloci
# 2 import genome
# 3 read leading and trailing regions.
# 4 compare complementary kmea perc.

k = 10
w = 200
kmer_threshold = 20

for gff_file in meta_annotations:

	if not gff_file.stem.startswith("Cocin"):
		continue

	abbv = gff_file.stem[:5]

	# print(gff_file)

	genome_file = genome_d[abbv]

	total_score = 0
	start    = None
	stop     = None
	in_locus = False
	best_score = 0


	with open(genome_file, 'r') as f:

		for line in f:
			if line.startswith(">"):
				contig = line.lstrip(">").rstrip()
				contig = contig.split()[0]

				print(contig)
				base_i = 0
				dq1 = deque(["A"] * w)
				dq2 = deque(["A"] * w) 
				kc1 = Counter(["A"*k]*(w-k))
				kc2 = Counter(["A"*k]*(w-k))
				continue

			line = line.strip()

			for base in line:
				base_i += 1
				dq2.append(base.upper())

				kmer = "".join(list(itertools.islice(dq2, 0, k)))
				if "N" not in kmer:
					kc1[kmer] += 1
					kc2[complement(kmer)] -= 1
					if kc1[complement(kmer)] == 0:
						del kc1[complement(kmer)]


				kmer = "".join(list(itertools.islice(dq2, len(dq2)-k, len(dq2))))
				if "N" not in kmer:
					kc2[complement(kmer)] += 1

				kmer = "".join(list(itertools.islice(dq1, 0, k)))
				if "N" not in kmer:
					kc1[kmer] -= 1
					if kc1[kmer] == 0:
						del kc1[kmer]


				dq1.popleft()
				dq1.append(dq2.popleft())


				# pprint(kc1)
				# print()
				# pprint(kc2)
				# print()
				last_score = total_score
				overlap = kc1 & kc2
				total_score = sum(overlap.values())

				if total_score >= kmer_threshold:

					if in_locus:
						stop = base_i
						best_score = max([best_score, total_score])

					else:
						start    = base_i - w
						stop     = base_i
						in_locus = True
						best_score = total_score

				elif in_locus and start >= 0:
					in_locus = False
					print()
					print(best_score)
					print(f"  {contig}:{start}-{stop}")
				# if total_score > 0:
				# 	print(" ", base_i, total_score)




def make_fasta(annotation_file, genome_file):
	genf = pysam.FastaFile(genome_file)

	abbv = annotation_file.name[:5]

	query_file = Path(query_dir, f"{abbv}.meta.fa")

	with open(query_file, 'w') as outf:
		with open(annotation_file, 'r') as f:

			for line in f:
				if line.startswith("#"):
					continue


				line = line.strip().split("\t")

				if len(line) == 1:
					continue





				contig  = line[0]
				feature = line[2]


				# if feature.lower() == 'otherrna':
				# 	continue

				start   = line[3]
				stop    = line[4]
				strand  = line[6]
				ID      = line[8].split(';')[0].split("=")[1]


				region = f"{contig}:{start}-{stop}"


				out = genf.fetch(region=region)

				out = out.upper()


				if strand == '-':
					out = out[::-1]
					out = complement(out, dna=True)


				if out:
					print(f">{ID}", file=outf)
					print(out, file=outf)

				# print(out)

	genf.close()

	return(query_file)





















