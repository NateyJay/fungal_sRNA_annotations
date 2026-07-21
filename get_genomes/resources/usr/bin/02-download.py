#!/usr/bin/env python3

import polars as pl
from pathlib import Path
from subprocess import Popen, PIPE
import sys
import json
from pprint import pprint
import shutil


genome_folder = Path("../+genomes")
genome_folder.mkdir(parents = True, exist_ok = True)

genome_file = Path("01out-selected_genomes.xlsx")

df = pl.read_excel(genome_file)

df = df.filter(pl.col("selected") != "",)
df = df.filter(pl.col("selected").is_not_null(),)


accessions = df.get_column("accession").to_list()
abbvs      = df.get_column("abbv").to_list()


done_abbvs = [a.name[:5] for a in genome_folder.glob("*.fa")]

with open("../+genomes/+genome_files.txt", 'w') as outf:
	outf.write('')

for i,acc in enumerate(accessions):

	try:
		shutil.rmtree('ncbi_dataset')
	except:
		pass

	abbv = abbvs[i]

	# print()
	# print(abbv, acc)

	if abbv in done_abbvs:
		print(abbv, "found")
		stem = list(genome_folder.glob(f"{abbv}.*.fa"))[0].stem

	else:
		print()
		print(abbv, 'downloading')

		p = Popen(f"datasets download genome accession {acc} --include genome,gff3", shell=True)
		p.wait()

		print()
		print('  unpacking...')

		shutil.unpack_archive('ncbi_dataset.zip')


		assembly_dir = list(Path().glob("./ncbi_dataset/data/*/"))[0]


		for file in assembly_dir.glob("*"):
			# new_name = file.with_stem(f"{abbv}.{file.stem}")

			if file.suffix == ".fna":

				stem = file.stem

				break

		print(f"  stem: {stem}")

		# print(Path(f"ncbi_dataset/data/{acc}/{stem}.fna").is_file(), f"ncbi_dataset/data/{acc}/{stem}.fna")
		# sys.exit()

		try:
			shutil.move(f"ncbi_dataset/data/{acc}/{stem}.fna", f"../+genomes/{abbv}.{stem}.fa")
			print("    [x] genome")
		except FileNotFoundError:
			print("    [ ] genome")

		try:
			shutil.move(f"ncbi_dataset/data/{acc}/genomic.gff", f"../+genomes/{abbv}.{stem}.gff3")
			print("    [x] annotation")
		except FileNotFoundError:
			print("    [ ] annotation")


	
	with open("../+genomes/+genome_files.txt", 'a') as outf:
		print(abbv, stem, sep='\t', file=outf)

		# if abbv == 'Alalt':
		# 	sys.exit()
		# # sys.exit()








