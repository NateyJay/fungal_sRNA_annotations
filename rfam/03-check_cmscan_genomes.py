





import sys
from pathlib import Path
from pprint import pprint
from subprocess import Popen, PIPE


genome_d = {}
for genome_file in Path("../+genomes").glob("*.fa"):
	genome_d[genome_file.name[:5]] = genome_file.name

scan_dir = Path("01out-cmscans")


to_remove = []

for scan_file in scan_dir.glob("*.cmscan"):
	with open(scan_file,'r') as f:
		for line in f:
			line = line.strip()

			if line.startswith("# query sequence file:"):
				# print(line)

				query_file = Path(line.split()[-1]).name
				break


	abbv = scan_file.name[:5]
	# print(query_file)

	if abbv not in genome_d:
		find_val = " "
	elif genome_d[abbv] == query_file:
		find_val = "x"
	else:
		find_val = "?"
		to_remove.append(abbv)

	print(find_val, query_file)


print()
print()
print('to remove:')
for abbv in to_remove:
	print(" ", abbv)


print()
print()
print("remove commands:\n")
for abbv in to_remove:
	print(f"rm 01out-cmscans/{abbv}.cmscan")
	print(f"rm 01out-cmscans/{abbv}.txt")
	print(f"rm 02out-rfam_gffs/{abbv}.rfam.gff3")

