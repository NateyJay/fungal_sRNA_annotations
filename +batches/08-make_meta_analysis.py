import sys
from pprint import pprint

from subprocess import Popen, PIPE
from pathlib import Path

from openpyxl import load_workbook

from random import shuffle

run_all_anyways = True

script_dir = Path("08out-scripts")
script_dir.mkdir(parents=True, exist_ok=True)

Path("08out-batch_outputs").mkdir(parents=True, exist_ok=True)



def check_done(project):
	return(False)
	log_file = Path("../annotations", project, f"hairpin", "log.txt")
	if not log_file.is_file():
		return False

	with open(log_file, 'r') as f:
		for line in f:
			if "Run completed:" in line:
				return True


config_file = Path("08-config.txt")
with open(config_file, 'w') as outf:
	outf.write('ArrayTaskID\tProject\tAnnDir\n')



print("")
print("To run:")
to_run = []

with open("../simple_metaloci/projects.txt", 'r') as f:
	projects = f.readlines()

for project in projects:
	abbv      = project.split(".")[0]
	meta_file = f"../../simple_metaloci/{abbv}.simple.gff3"

	script_file = Path(script_dir, f"{project}.sh")
	
	with open(script_file, 'w') as outf:

		print(f"""#!/bin/bash


	source /home/opt/anaconda3/etc/profile.d/conda.sh
	conda activate nate_env

	mkdir ../annotations/{project}
	cd ../annotations/{project}

	echo {project}


	echo "analyze metaloci..."
	yasma.py analyze -o . -a align/alignment.bam --annotation_file {meta_file} --name metaloci




	""", file=outf)

		i += 1

	with open(config_file, 'a') as outf:
		print(i, "NA", str(script_file), project, f"../annotations/{project}", sep='\t', file=outf)
		

	if check_done(project) and not run_all_anyways:
		continue
	
	print(i, project, sep='\t')
	to_run.append(i)




# shuffle(to_run)

exec_file = Path("08-command.sh")
with open(exec_file, 'w') as outf:
	outf.write(f'''#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node 1
#SBATCH --output=08out-batch_outputs/%a.out.txt 
#SBATCH --error=08out-batch_outputs/%a.err.txt 
#SBATCH --array {",".join(map(str,to_run))}%6

module load bowtie

config=08-config.txt
file=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {{print $3}}' $config)
project=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {{print $4}}' $config)


sh $file



''')











