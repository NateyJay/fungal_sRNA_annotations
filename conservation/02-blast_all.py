

from config import *


def blast_command(a_fasta, b_genome, out_file):
	header = 'qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore'
	header = header.replace(' ', '\t')

	with open(out_file, 'w') as outf:
		print(header, file=outf)

	call1 = ['gzip', '-cd', str(b_genome)]
	call2 = ['blastn', '-query', str(a_fasta), '-subject', '-', '-outfmt', '6', '-task', "blastn"]
	


	p1 = Popen(call1, stdout=PIPE, encoding='utf-8')
	p2 = Popen(call2, stdout=PIPE, stdin=p1.stdout, encoding='utf-8')

	for line in p2.stdout:
		with open(out_file, 'a') as outf:
			print(line.strip(), file=outf)

	p1.wait()






meta_annotations = '../metaloci/03out-metaloci.fa'


targets = Path("01out-genomes").glob("*.fa.gz")

for t in targets:

	print(t)

	blast_command(meta_annotations, t, Path(blast_dir, f"{t.stem}.txt"))




