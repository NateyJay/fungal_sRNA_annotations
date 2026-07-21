
from pathlib import Path
from subprocess import Popen, PIPE
import sys
import json
from pprint import pprint
import zipfile
import gzip

# datasets summary genome taxon "fungi" --reference --as-json-lines > assemblies.jsonl
force = False
assembly_file = Path('assemblies.jsonl')

if force or not assembly_file.is_file():
	p = Popen('datasets summary genome taxon "fungi" --reference --as-json-lines > assemblies.jsonl',
			shell=True
		)
	p.wait()


# genome_dir = Path('01out-genomes')
genome_dir = "/Volumes/HeavyPoint/Fungal_genomes/"
genome_dir.mkdir(exist_ok=True)


def download_and_extract(chunk):

	if len(chunk) == 0:
		return


	accessions = [a for a,n in chunk]
	accessions = " ".join(accessions)

	attempt = 0

	while attempt < 3:

		command = f'datasets download genome accession {accessions}'
		print(command)
		p = Popen(command,
				shell=True, stdout=PIPE, stderr=PIPE
			)

		out, err = p.communicate()

		if len(err.strip()) > 0:
			print(err)
			print(f'attempt {attempt} -> trying again')
			attempt += 1
		else:
			break




	print("unpacking fastas...")

	with zipfile.ZipFile('ncbi_dataset.zip', 'r') as archive:
		for accession, assembly_name in chunk:

			src = f"ncbi_dataset/data/{accession}/{accession}_{assembly_name}_genomic.fna"
			dst = Path(genome_dir, f'{accession}_{assembly_name}_genomic.fa')
			zipped_fasta = dst.with_suffix('.fa.gz')

			print(f"   {dst.name}")

			try:
				archive.getinfo(src).filename = str(dst)
				archive.extract(src)
			except KeyError:
				print("   ^^^ error - src not found in zip archive")
				continue


			with open(dst,'rb') as f:
				with gzip.open(zipped_fasta, 'wb') as outf:
					for line in f:
						outf.write(line)

			dst.unlink()


with open(assembly_file, 'r') as f:
	chunk = list()

	for line in f:

		if len(chunk) == 50:
			download_and_extract(chunk)
			chunk = []


		line = json.loads(line)

		accession     = line['accession']
		assembly_name = line['assembly_info']['assembly_name'].replace(" ", "_")
		organism      = line['organism']['organism_name']
		length        = line['assembly_stats']['total_sequence_length']
		n_seqs        = line['assembly_stats']['number_of_component_sequences']
		tax_id        = line['organism']['tax_id']


		dst = Path(genome_dir, f'{accession}_{assembly_name}_genomic.fa')
		zipped_fasta = dst.with_suffix('.fa.gz')




		
		if not force and zipped_fasta.is_file():
			continue

		chunk.append((accession, assembly_name))


	download_and_extract(chunk)

