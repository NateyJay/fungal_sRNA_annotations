#!/usr/bin/python3

import sys
from pprint import pprint

from pathlib import Path
import os
from subprocess import Popen, PIPE, DEVNULL


annotation_dir = Path("../fungi_annotations_august/annotations/")

projects = os.listdir(annotation_dir)




projects = [p for p in projects if "PRJ" in p]

log_file = "control_alignment.txt"
with open(log_file, 'w') as outf:
	print('project','library', 'total','map','nonmap', sep='\t', file=outf)

print()
for project in projects:
	print(project, flush=True)

	alignment_file = Path(annotation_dir, project, 'nativealign', 'alignment.bam',)
	rgs = []

	call = ['samtools','view','-H',str(alignment_file)]
	p = Popen(call, stdout=PIPE, encoding='utf-8')
	for line in p.stdout:
		line = line.strip()
		if line.startswith("@RG"):
			rgs.append(line.split()[1].lstrip("ID:"))


	open_files = {}
	for rg in rgs:
		open_files[rg] = open(f"{rg}.fa", 'w')




	call = ['samtools','fasta', '-t', str(alignment_file)]

	p = Popen(call, stdout=PIPE, encoding='utf-8')

	for line in p.stdout:
		line = line.strip()

		if line.startswith(">"):
			rg = line.split()[1].lstrip("RG:Z:")

			print(line.split()[0], file=open_files[rg])
		else:
			print(line, file=open_files[rg])

	p.wait()

	for file in open_files.values():
		file.close()


	for rg in rgs:
		print("  ", rg, flush=True)
		fasta_file = f"{rg}.fa"



		call = ['bowtie', '-f', '-v', '1', '-p', '28', '-S', "-k", '1', '--best', '-x', "RF00026.fa", fasta_file]

		p = Popen(call, stderr=PIPE, stdout=DEVNULL, encoding='utf-8')

		total_reads = p.stderr.readline().strip().split()[-1]
		mapper      = p.stderr.readline().strip().split()[-2]
		nonmap      = p.stderr.readline().strip().split()[-2]

		p.wait()

		with open(log_file, 'a') as outf:
			print(project, rg, total_reads, mapper, nonmap, sep='\t', file=outf)







