import sys
from pathlib import Path
import os
from subprocess import Popen, PIPE



annotations = {}
genome_dir = Path("../+genomes")

for g in genome_dir.iterdir():
	abbv = g.name.split(".")[0]

	if g.suffix == '.gff':
		annotations[abbv] = Path(genome_dir, g.name)



for project in os.listdir("../+annotations"):

	project_dir = Path("..", "+annotations", project)



	if project[5] != ".":
		continue

	print(project)
	abbv = project[:5]


	if abbv not in annotations:
		continue


	gene_annotation = annotations[abbv]

	names = [n.lstrip("tradeoff_") for n in os.listdir(project_dir) if n.startswith("tradeoff_")]

	for n in names:
		print(" ", n)

		locus_file = Path(project_dir, f'tradeoff_{n}', 'loci.gff3')

		# print(locus_file)
		# print(locus_file.exists())
		if not locus_file.exists():
			continue

		call = ['yasma.py', 'context', '-o', project_dir, '-ga', gene_annotation, '-n', n]
		print("    ", " ".join(map(str, call)))

		# print(project_dir)
		# sys.exit()

		p = Popen(call, stdout=PIPE, stderr=PIPE, encoding='utf-8')

		out, err = p.communicate()
		print(err)

		# input("holding for input...")
		# sys.exit()



