import sys
from pathlib import Path
from pprint import pprint




with open("01out-annotation_stats.txt", 'w') as outf:
	print('project', 'total_reads', 'total_genome', 'revised_reads_annotated', 'revised_genome_annotated', 'final_reads_annotated', 'final_genome_annotated', sep='\t', file=outf)


	log_files = Path().glob("../+annotations/*/tradeoff/log.txt")

	for log_file in log_files:

		project = log_file.parts[-3]
		# print(project)

		with open(log_file, 'r') as f:
			for line in f:
				line = line.strip()

				# print(line)


				if "chromosomes/scaffolds/contigs" in line:

					total_genome = int(f.readline().strip().split()[0].replace(",",''))
					total_reads  = int(f.readline().strip().split()[0].replace(",",''))


				if "revising regions" in line:

					try:
						revised_genome_annotated = int(f.readline().strip().split()[0].replace(",",''))
						revised_reads_annotated  = int(float(f.readline().strip().split()[0].replace(",",'')))
					except IndexError:
						break


				if "final annotation metrics:" in line:

					final_genome_annotated = int(f.readline().strip().split()[0].replace(",",''))
					final_reads_annotated  = int(float(f.readline().strip().split()[0].replace(",",'')))



			print(project, total_reads, total_genome, revised_reads_annotated, revised_genome_annotated, final_reads_annotated, final_genome_annotated, sep='\t', file=outf)
			# sys.exit()








