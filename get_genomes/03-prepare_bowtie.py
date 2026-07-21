import polars as pl
from pathlib import Path
from subprocess import Popen, PIPE, DEVNULL
import sys
import json
from pprint import pprint
import shutil


genome_folder = Path("../+genomes")
genome_folder.mkdir(parents = True, exist_ok = True)



for genome in genome_folder.glob(f"*.fa"):

	genome_name = "_".join(genome.stem.split("_")[:2])

	if genome.with_suffix(".1.ebwt").is_file():
		print(genome_name, 'found')
		continue

	print(genome_name, 'building')

	p = Popen(f"bowtie-build {genome} {genome.with_suffix("")}", shell=True, stderr=DEVNULL, stdout=DEVNULL)
	p.wait()

