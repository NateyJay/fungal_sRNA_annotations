import sys
from pprint import pprint
from pathlib import Path


import json
from subprocess import Popen, PIPE


unfiltered_file = '00out-unfiltered_fungi_genera.json'

def query_datasets():
	with open(unfiltered_file, 'w') as outf:
		p = Popen("datasets summary taxonomy taxon fungi --children --rank GENUS", shell=True, stdout=outf)
		p.wait()

if not Path(unfiltered_file).is_file():
	query_datasets()

with open(unfiltered_file, 'r') as f:
	summ_d = json.load(f)['reports']


genera = []
for entry in summ_d:
	# pprint(entry)


	genus = entry['taxonomy']['current_scientific_name']['name']
	genus = genus.strip("[").strip("]")

	# print(genus)
	genera.append(genus)
	# sys.exit()

genera = list(set(genera))
genera.sort()


genera.remove("Drosophila")
genera.remove("Melanogaster")
genera.remove("Scleroderma")


with open("00out-fungal_genera.txt", 'w') as outf:
	for genus in genera:
		print(genus)
		print(genus, file=outf)

print()
print()

print(len(genera), "genera found")



