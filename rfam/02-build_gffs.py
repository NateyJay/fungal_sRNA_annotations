





import sys
from pathlib import Path
from pprint import pprint
from subprocess import Popen, PIPE




scan_dir = Path("01out-cmscans")

out_dir = Path("02out-rfam_gffs")
out_dir.mkdir(parents=True, exist_ok=True)


scans = [p for p in scan_dir.glob("*.txt")]


header = ['idx',
'target name',
'accession',
'query name',
'accession',
'clan name',
'mdl',
'mdl from',
'mdl to',
'seq from',
'seq to',
'strand',
'trunc' ,
'pass',
'gc',
'bias',
'score',
'E-value',
'inc',
'olp',
'anyidx',
'afrct1',
'afrct2',
'winidx',
'wfrct1',
'wfrct2',
'mdl len',
'seq len',
'description of target']

for scan_file in scans:

	abbv = scan_file.name[:5]
	out_file = Path(out_dir, f"{abbv}.rfam.gff3")

	print(abbv)

	if not scan_file.is_file():
		print("   ^^^ cmscan table not found")
		continue

	with open(out_file, 'w') as outf:
		print("##gff-version 3", file=outf)

		with open(scan_file, 'r') as f:
			# header = f.readline().strip().strip("#").split('\t')
			# print(header)
			# sys.exit()

			for line in f:
				if line.startswith("#"):
					continue

				line = line.strip().split()
				# print(line)

				if len(line) < len(header):
					print("   ^^^ incomplete table")
					break


				desc = " ".join(line[header.index('description of target'):])

				attrs = f"ID={line[header.index('accession')]};eval={line[header.index('E-value')]};desc={desc}"

				feature = line[header.index("target name")]

				if "tRNA" in feature:
					feature = 'tRNA'

				elif "rRNA" in feature:
					feature = 'rRNA'

				elif "sno" in feature:
					feature = 'snoRNA'

				elif "snR" in feature:
					feature = 'snRNA'

				elif "U2" in feature:
					feature = 'spliceosomal'

				elif "U3" in feature:
					feature = 'spliceosomal'

				elif "U4" in feature:
					feature = 'spliceosomal'

				elif "U5" in feature:
					feature = 'spliceosomal'

				elif "U6" in feature:
					feature = 'spliceosomal'

				else:
					feature = f"other"

				start = int(line[header.index("seq to")])
				stop  = int(line[header.index("seq from")])

				if stop < start:
					start, stop = stop, start

				out_line = []

				out_line += [line[header.index("query name")]]
				out_line += ['Rfam']
				out_line += [feature]
				out_line += [start]
				out_line += [stop]
				out_line += [line[header.index("score")]]
				out_line += [line[header.index("strand")]]
				out_line += ['.']
				out_line += [attrs]

				print("\t".join(map(str, out_line)), file=outf, sep='\t')



