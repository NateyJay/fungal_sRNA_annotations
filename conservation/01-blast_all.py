

from config import *







def complement(s, dna=False):
	d = {"U":"A", 
	"A":"U", "G":"C", "C":"G", "N":"N"}

	if dna:
		d['T'] = 'A'
		d['A'] = 'T'



	try:
		s = "".join([d[letter] for letter in s])
	except KeyError:
		print(f"Warning: sequence {s} ommitted")
		return(False)
	return(s)

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

def blast_command(a_fasta, b_genome, out_file):
	header = 'qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore'
	header = header.replace(' ', '\t')

	with open(out_file, 'w') as outf:
		print(header, file=outf)

		call = ['blastn', '-query', str(a_fasta), '-subject', str(b_genome), '-outfmt', '6']
		p = Popen(call, stdout=PIPE, encoding='utf-8')

		for line in p.stdout:
			print(line.strip(), file=outf)

		p.wait()



print(f"{len(meta_annotations)} meta_annotations")



combs = list(itertools.combinations(meta_annotations, 2))
print(f" -> {len(combs)} unique combinations")
print()
i = 1
for a, b in combs:
	a_abbv = a.name[:5]
	b_abbv = b.name[:5]

	print(f"{i}/{len(combs)}\t{a_abbv} -> {b_abbv}")


	b_genome = genome_d[b_abbv]

	query_file = make_fasta(a, genome_d[a_abbv])
	out_file = Path(blast_dir, f"{a_abbv}_to_{b_abbv}.txt")

	blast_command(query_file, b_genome, out_file)

	i += 1














