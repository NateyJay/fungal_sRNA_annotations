
import sys
from pprint import pprint
from pathlib import Path
import itertools
import pysam
from subprocess import Popen, PIPE


meta_annotations = list(Path('../metaloci').glob("*.meta.gff3"))

genomes = list(Path('../+genomes').glob("*genomic.fa"))
genome_d = {}
for g in genomes:
	abbv = g.name[:5]

	genome_d[abbv] = g

blast_dir = Path("01out-blast_tables")
blast_dir.mkdir(parents=True, exist_ok=True)

query_dir = Path("01out-queries")
query_dir.mkdir(parents=True, exist_ok=True)

gff_dir = Path("02out-gffs")
gff_dir.mkdir(parents=True, exist_ok=True)