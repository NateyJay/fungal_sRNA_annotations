import polars as pl
from pathlib import Path
from subprocess import Popen, PIPE
import sys
import json
from pprint import pprint
import shutil
import requests

genome_folder = Path("../+genomes")
genome_folder.mkdir(parents = True, exist_ok = True)

genome_file = Path("01out-selected_genomes.xlsx")

df = pl.read_excel(genome_file)

# df = df.filter(pl.col("selected") != "",)
# df = df.filter(pl.col("selected").is_not_null(),)


accessions = df.get_column("accession").to_list()
abbvs      = df.get_column("abbv").to_list()


genome_dones = [a.name[:5] for a in genome_folder.glob("*.fa")]
cds_dones    = [a.name[:5] for a in genome_folder.glob("*.cds.fa")]
rna_dones    = [a.name[:5] for a in genome_folder.glob("*.rna.fa")]

with open("../+genomes/+genome_files.txt", 'w') as outf:
	outf.write('')


for i, row in enumerate(df.iter_rows(named=True)):

	if not row['selected']:
		continue


	try:
		shutil.rmtree('ncbi_dataset')
	except:
		pass

	abbv = row['abbv']
	acc  = row['accession']

	# if abbv != "Asapi":
	# 	continue

	base_name = f"{abbv}.{row['accession']}_{row['assembly_name']}"

	genome_file = Path("../+genomes", base_name+"_genomic.fa")
	gff3_file   = Path("../+genomes", base_name+"_genomic.gff3")
	cds_file    = Path("../+genomes", base_name+"_cds.fa")
	rna_file    = Path("../+genomes", base_name+"_rna.fa")
	report_file = Path("../+genomes", base_name+"_assembly_report.txt")


	to_do = []

	if not genome_file.is_file():
		to_do.append('genome')

	if not gff3_file.is_file():
		to_do.append('gff3')

	if row['ann_name'] and not cds_file.is_file():
		to_do.append("cds")

	if not report_file.is_file():
		to_do.append("seq-report")

	# if row['ann_name'] and not rna_file.is_file():
	# 	to_do.append("rna")

	print()
	print(abbv, row['accession'], 'downloading')
	if len(to_do) == 0:
		print('  all done!')
		continue


	command = f"datasets download genome accession {row['accession']} --include {",".join(to_do)}"
	print(command)
	p = Popen(command, shell=True)
	p.wait()

	print()
	print('  unpacking...')

	if not Path('ncbi_dataset.zip').is_file():
		print("Error: did not download for some reason....")
		continue
		 
	shutil.unpack_archive('ncbi_dataset.zip')


	try:
		assembly_dir = list(Path().glob("./ncbi_dataset/data/*/"))[0]
	except IndexError:
		assembly_dir = None


	if not assembly_dir:
		print('unknown error with this accession!!')
		continue


	def move_to(a, b, name):
		try:
			shutil.move(a, b)
			print(f"    [x] {name}")
		except FileNotFoundError:
			print(f"    [ ] {name}")

	stem = f"{abbv}.{row['accession']}_{row['assembly_name']}"

	rna_found = False
	cds_found = False

	for file in assembly_dir.glob("*"):
		# new_name = file.with_stem(f"{abbv}.{file.stem}")

		if file.name == 'genomic.gff':
			move_to(file, f"../+genomes/{stem}_genomic.gff3", 'gff3')

		elif file.name == 'cds_from_genomic.fna':
			move_to(file, f"../+genomes/{stem}_cds.fa", 'cds')
			cds_found = True

		elif file.name == 'rna.fna':
			move_to(file, f"../+genomes/{stem}_rna.fa", 'rna')
			rna_found = True

		elif file.name.endswith("genomic.fna"):
			move_to(file, f"../+genomes/{stem}_genomic.fa", 'genome')

		elif file.name == 'sequence_report.jsonl':
			move_to(file, f"../+genomes/{stem}_sequence_report.jsonl", 'assembly_report')


	if "rna" in to_do and not rna_found:
		sys.exit("http://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/182/895/GCA_000182895.1_CC3/GCA_000182895.1_CC3_rna_from_genomic.fna.gz")

	if 'cds' in to_do and not cds_found:

		url = f"http://ftp.ncbi.nlm.nih.gov/genomes/all/{acc[:3]}/{acc[4:7]}/{acc[7:10]}/{acc[10:13]}/{acc}_{row['assembly_name']}/{stem}_cds_from_genomic.fna.gz"

		r = requests.get(url)
		sys.exit("CDS file not found!!")



	
	with open("../+genomes/+genome_files.txt", 'a') as outf:
		print(abbv, stem, sep='\t', file=outf)

		# if abbv == 'Alalt':
		# 	sys.exit()
		# # sys.exit()








