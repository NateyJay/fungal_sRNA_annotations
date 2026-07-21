import sys
from pathlib import Path
from subprocess import Popen, PIPE
from pprint import pprint


# hpc
# assemblies = list(Path("genomes").glob("*/"))
# local
abbvs = list(Path("../+genomes").glob("*.fa"))
abbvs = [a.stem[:5] for a in Path("../+genomes").glob("*.fa")]
abbvs = list(set(abbvs))
abbvs.sort()


log_folder = Path("01out-logs")
log_folder.mkdir(parents = True, exist_ok = True)

# print(assemblies)

def check_done(log_file):
	if not log_file.is_file():
		return(False)
	with open(log_file, 'r') as f:
		for line in f:
			if "Evaluation of TE annotation finished!" in line:
				return(True)

	return(False)

for i, abbv in enumerate(abbvs):

	if abbv == 'Gimar':
		print('skipping Gimar...')
		continue


	# omes = list(assembly.glob('*.fna')) #hpc
	omes = list(Path("../+genomes").glob(f"{abbv}*.fa"))


	genome_file = list(Path("../+genomes").glob(f"{abbv}*_genomic.fa"))
	cds_file    = list(Path("../+genomes").glob(f"{abbv}*_cds.fa"))



	print()
	print(f"Abbv {i}")
	print(" ", abbv)



	if not cds_file:
		print("  cds_file not found")
		continue
	cds_file = cds_file[0]

	if not genome_file:
		print("  genome_file not found")
		continue
	genome_file = genome_file[0]


	print(" ", genome_file)
	print(" ", cds_file)

	out_file = Path(log_folder, f"{abbv}.out.txt")
	err_file = Path(log_folder, f"{abbv}.err.txt")

	if check_done(out_file):
		print("  EDTA analysis complete...")
		continue

	outf = open(out_file, 'w')
	errf = open(err_file, 'w')

	command = f"EDTA.pl --genome {genome_file.name} --cds {cds_file.name} --overwrite 1 --sensitive 1 --anno 1 --threads 10 --force 1"

	# print(command)

	p = Popen(command, shell=True, stdout=outf, stderr=errf, cwd="../+genomes/")
	p.wait()

	outf.close()
	errf.close()

	# sys.exit()



