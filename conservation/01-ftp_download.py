import urllib.request

from pathlib import Path
from subprocess import Popen, PIPE
import sys
import json
from pprint import pprint
import zipfile
import gzip

import time
import threading
from multiprocessing import Pool, Lock

def init(lock):
    global starting
    starting = lock


def make_url(accession, assembly_name):
	# expected = 'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/003/125/GCA_000003125.1_JCVI-TSTA1-3.0/GCA_000003125.1_JCVI-TSTA1-3.0_genomic.fna.gz'


	link = f'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/{accession[0:3]}/{accession[4:7]}/{accession[7:10]}/{accession[10:13]}/{accession}_{assembly_name}/{accession}_{assembly_name}_genomic.fna.gz'
	
	return(link)

def download_file(entry):

	starting.acquire() # no other process can get it until it is released
	threading.Timer(0.5, starting.release).start() # release in a second

	i, accession, assembly_name, zipped_fasta = entry


	temp_fasta = zipped_fasta.with_suffix(".tmp.fa.gz")

	


	
	print('INIT', time.strftime('%a %H:%M:%S'), i, zipped_fasta.name, sep='\t')


	link = make_url(accession, assembly_name)

	try:
		urllib.request.urlretrieve(link, str(temp_fasta))
	except urllib.error.URLError:
		print('FAIL', time.strftime('%a %H:%M:%S'), i, zipped_fasta.name, sep='\t')
		return

	temp_fasta.rename(zipped_fasta)
	print('DONE', time.strftime('%a %H:%M:%S'), i, zipped_fasta.name, sep='\t')


if __name__ == '__main__':  # Essential for multiprocessing on Windows

	# datasets summary genome taxon "fungi" --reference --as-json-lines > assemblies.jsonl
	force = False
	assembly_file = Path('assemblies.jsonl')

	if force or not assembly_file.is_file():
		p = Popen('datasets summary genome taxon "fungi" --reference --as-json-lines > assemblies.jsonl',
				shell=True
			)
		p.wait()


	# genome_dir = Path('01out-genomes')
	genome_dir = Path("/Volumes/HeavyPoint/Fungal_genomes/")
	genome_dir.mkdir(exist_ok=True)

	jobs = []

	i = 0
	already_done = 0
	with open(assembly_file, 'r') as f:

		for line in f:

			line = json.loads(line)

			accession     = line['accession']
			assembly_name = line['assembly_info']['assembly_name'].replace(" ", "_")
			organism      = line['organism']['organism_name']
			length        = line['assembly_stats']['total_sequence_length']
			n_seqs        = line['assembly_stats']['number_of_component_sequences']
			tax_id        = line['organism']['tax_id']
			zipped_fasta = Path(genome_dir, f'{accession}_{assembly_name}_genomic.fa.gz')

			if not force and zipped_fasta.is_file():
				already_done += 1
				continue

			i += 1
			jobs.append((i, accession, assembly_name, zipped_fasta))


	num_processes = 12  # Or based on your CPU cores


	print(f"{already_done} genomes already downloaded")

	print(f"downloading {len(jobs):,} from the ncbi ftp server over {num_processes} processes")
	print()

	with Pool(processes=num_processes, initializer=init, initargs=[Lock()]) as p:
		for result in p.imap(download_file, jobs):
			# print(result)
			pass





