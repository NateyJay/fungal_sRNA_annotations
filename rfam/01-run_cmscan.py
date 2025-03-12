

import sys
from pathlib import Path
from pprint import pprint
from subprocess import Popen, PIPE


genome_d = {g.name[:5] : g for g in Path("../+genomes").glob("*.fa")}

# abbvs = [m.name[:5] for m in Path("../metaloci").glob("*.meta.gff3")]
abbvs = [m.name[:5] for m in Path("../+genomes").glob("*.fa")]


out_dir = Path("01out-cmscans")
out_dir.mkdir(parents=True, exist_ok=True)


for abbv in abbvs:
	print(abbv)

	out_file = Path(out_dir, f"{abbv}.txt")

	if out_file.is_file() and out_file.stat().st_size > 1000:
		print(f"  output found, skipping...")
		continue


	genome = genome_d[abbv]

	p = Popen(f"cat {genome} | grep -v '>' | wc -c", shell=True, stdout=PIPE, stderr=PIPE, encoding='utf-8')
	out, err = p.communicate()

	genome_size = int(out.strip())
	genome_size = genome_size / 1000000

	# print(genome_size)


	call = f"cmscan -Z {genome_size} --cpu 16 --cut_ga --rfam --nohmmonly --tblout {out_file} --fmt 2 --clanin Rfam.clanin Rfam.cm {genome} > {out_file.with_suffix('.cmscan')}"
	p = Popen(call, shell=True)
	p.wait()





