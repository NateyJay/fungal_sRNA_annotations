

from config import *





combs = list(itertools.combinations(meta_annotations, 2))

i = 1

for a, b in combs:
	a_abbv = a.name[:5]
	b_abbv = b.name[:5]

	print(f"{i}/{len(combs)}\t{a_abbv} -> {b_abbv}")


	blast_file = Path(blast_dir, f"{a_abbv}_to_{b_abbv}.txt")
	temp_gff = Path(gff_dir, f"{a_abbv}_to_{b_abbv}.gff3")


	if not blast_file.is_file():
		continue


	# header = 'qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore'
	# header = header.split()

	with open(temp_gff, 'w') as outf:
		with open(blast_file, 'r') as f:
			header = f.readline().split()

			for line in f:
				line = line.strip().split('\t')

				start = int(line[8])
				stop  = int(line[9])

				if start < stop:
					strand = "+"
				else:
					start, stop = stop, start
					strand = "-"

				gff_line = [
					line[header.index('sseqid')],
					'blastn',
					'NA',
					str(start),
					str(stop),
					line[header.index("evalue")],
					strand,
					'.',
					f"ID={line[header.index('qseqid')]};pident={line[header.index('pident')]};length={line[header.index('length')]};bitscore={line[header.index('bitscore')]};evalue={line[header.index('evalue')]}"
				]

				print('\t'.join(gff_line), file=outf)


	i += 1






