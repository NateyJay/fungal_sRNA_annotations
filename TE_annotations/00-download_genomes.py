import sys
from pathlib import Path
from subprocess import Popen, PIPE
import shutil


genome_folder = Path("./genomes")
genome_folder.mkdir(parents = True, exist_ok = True)

# genome_table = "../+genomes/+genome_files.txt"
genome_table = "./+genome_files.txt"

with open(genome_table, 'r') as f:
	for line in f:
		line = line.strip().split()
		acc = line[1][6:]
		acc = "_".join(acc.split("_")[:2])


		if genome_folder.is_dir():
			fastas = list(Path(genome_folder, acc).glob("*.fna"))
			if len(fastas) > 0:
				print(f"{acc}\tdone")
				continue


		print(f"{acc}\tdownloading")
		try:
			shutil.rmtree('ncbi_dataset')
		except:
			pass


		call = f"datasets download genome accession {acc} --include genome,cds"

		p = Popen(call, shell=True)
		p.wait()


		## unpacking and moving genome dir
		shutil.unpack_archive('ncbi_dataset.zip')
		shutil.move(f"ncbi_dataset/data/{acc}", f"./genomes/{acc}")

		## cleanup
		shutil.rmtree('ncbi_dataset')
		Path("ncbi_dataset.zip").unlink()
		Path("README.md").unlink()
		Path("md5sum.txt").unlink()

		print()
