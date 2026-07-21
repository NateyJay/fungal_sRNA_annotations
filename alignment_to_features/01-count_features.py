

from pathlib import Path
import sys
from pprint import pprint
import pysam
from collections import deque, Counter



project = 'Bocin.PRJNA253747'
abbv    = 'Bocin'

out_dir = Path("01out-counts")
out_dir.mkdir(parents=True, exist_ok=True)

force = False


def get_counts(project):

	print(project)
	abbv = project[:5]


	if abbv in ["Gimar", "Asfla"]:
		return

	gff_file = f"../integrated_annotations/{abbv}.integrated.gff3"
	bam_file = f"/Volumes/fungal_srnas/Annotations/{project}/align/alignment.bam"

	if not Path(bam_file).is_file():
		print("   bam file not found...")
		return

	if not Path(gff_file).is_file():
		print("   gff file not found...")
		return


	out_file = Path(out_dir, f"{project}.feature_counts.txt")
	if out_file.is_file() and not force:
		print("  -> already done")
		return

	features = deque()
	with open(gff_file) as f:
		for line in f:
			if line.startswith("#"):
				continue

			line = line.strip().split()

			entry = (line[0], int(line[3]), int(line[4]), line[2])

			features.append(entry)


	read_i = 0
	c = Counter()
	with pysam.AlignmentFile(bam_file, "rb") as bamf:
		header = bamf.header.to_dict()
		contigs = [entry['SN'] for entry in header['SQ']]

		for read in bamf:


			if read_i % 1000000 == 0:
				# print()
				# print(f"read_i: {read_i:,}\t{read.reference_name}")
				# pprint(c)
				print(f"  {read_i}", end='\r')

			read_i += 1

			if 21 <= read.query_length <= 24:
				sizing = 'sRNA'
			else:
				sizing = 'other'

			if read.is_unmapped:
				c[(sizing,'unmapped')] += 1
				continue





			# print()
			# print(f"read_coords: {read.reference_name}:{read.reference_start}-{read.reference_end}")
			kills = []
			i = 0

			found_features = set()
			while True:
				try:
					contig, start, end, feature_type = features[i]
				except IndexError:
					break



				# print(f"feature_coords: {contig}:{start}-{end}")

				if contigs.index(contig) > contigs.index(read.reference_name):
					# print('features are ahead of reads (contig)')
					break

				if contig != read.reference_name:
					# print('eliminating passed feature (contig)')
					features.popleft()
					continue

				if start > read.reference_end:
					# print('features are ahead of reads (coord)')
					break

				if end < read.reference_start:
					# print('eliminating passed feature (coord)')
					features.popleft()
					continue

				found_features.add(feature_type)
				i += 1

			found_features = sorted(list(found_features))
			found_features = ",".join(found_features)

			c[(sizing, found_features)] += 1
			# print(found_features)

	print()
	print(f"  writing to: {out_file}")

	with open(out_file, 'w') as outf:
		print("project\tsizing\tcount\tfeature", file=outf)
		for key, value in c.most_common():

			sizing, feature = key

			print(project, sizing, value, feature, sep='\t', file=outf)

	print()


			# pprint(c)
			# input()



for p in Path(f"/Volumes/fungal_srnas/Annotations/").glob("*"):
	project = p.name

	# project = 'Bocin.PRJNA253747'

	get_counts(project)
	# sys.exit()











sys.exit()

gene_gff = Path('/Users/jax/🔬Research/🔍2024 - fungal_sRNA_annotations/+genomes/Bocin.GCF_000143535.2_ASM14353v4_genomic.gff3')
srna_gff = Path('/Users/jax/🔬Research/🔍2024 - fungal_sRNA_annotations/metaloci/01out-meta_gffs/Bocin.meta.gff3')
te_gff   = Path('/Users/jax/🔬Research/🔍2024 - fungal_sRNA_annotations/TE_annotations/eg_out/Bocin_EarlGrey/Bocin_summaryFiles/Bocin.filteredRepeats.gff')
rfam_gff = Path('/Users/jax/🔬Research/🔍2024 - fungal_sRNA_annotations/rfam/02out-rfam_gffs/Bocin.rfam.gff3')















sys.exit()

def import_gff(gff_file, include=[], exclude=[]):
	d = {}
	print(gff_file)
	with open(gff_file) as f:
		for line in f:
			if line.startswith("#"):
				continue

			line = line.strip().split('\t')

			contig = line[0]
			start  = int(line[3])
			end    = int(line[4])
			feature = line[2]

			if include:

				if feature in include:

					for r in range(start, end+1):

						try:
							d[(contig, r)].add(feature)

						except KeyError:
							d[(contig, r)] = {feature}

				continue

			if exclude:
				if feature in exclude:
					continue

			for r in range(start, end+1):

				try:
					d[(contig, r)].add(feature)

				except KeyError:
					d[(contig, r)] = {feature}

	return(d)


feature_d = {}

print(import_gff(gene_gff, include=['gene']))




