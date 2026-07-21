import sys
from pathlib import Path
import pysam

genomes = {}

for genome in Path("../+genomes/").glob("*.fa"):
	# print(genome)

	genomes[genome.name[:5]] = genome


total_annotations = 0 
with open("03out-metaloci.fa", 'w') as outf:
	for ann_file in Path("01out-meta_gffs").glob("*meta.gff3"):

		genome_annotations = 0
		genome = genomes[ann_file.name[:5]]
		print(genome)

		fa = pysam.FastaFile(genome)

		with open(ann_file, 'r') as f:
			for line in f:
				if not line.startswith("#"):


					line= line.strip().split()

					chrom = line[0]
					type  = line[2]
					start = int(line[3])
					stop  = int(line[4])
					strand = line[6]

					attrs = line[8].split(";")

					name  = attrs[0].split("=")[-1]


					if type == "OtherRNA":
						continue

					try:
						seq = fa.fetch(reference=chrom, start=start, end=stop)
					except KeyError:
						pass

					genome_annotations += 1
					print(f">{name} type={type} strand={strand} length={stop-start}", file=outf)
					print(seq, file=outf)
					# sys.exit()
		print(f"   {genome_annotations:,}")


		total_annotations += genome_annotations

print()
print(f"extracted {total_annotations:,} annotations in total")



