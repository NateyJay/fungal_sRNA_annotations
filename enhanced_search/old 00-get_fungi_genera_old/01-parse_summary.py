import sys
from pprint import pprint


import json



summary_file = "00out-fungi_genomes.json"

with open(summary_file, 'r') as f:
	summ_d = json.load(f)['reports']


def get_sci_name(entry):
	try:
		sci_name = entry['assembly']['org']['sci_name']
		tax_id   = entry['assembly']['org']['tax_id']
		rank     = entry['assembly']['org']['rank']
	except KeyError:
		# pprint(entry['assembly']['org'])
		rank=None
		# input()

	return(sci_name, tax_id, rank)

# pprint(summ_d)

# pprint(summ_d['assemblies'][0])
banned_words = set(['uncultured', 'fungal', 'sp.', 'No.11243', 'ARF18', "EF0021"])
genera = set()
for assembly in summ_d:
	pprint(assembly)

	sci_name, tax_id, rank = get_sci_name(assembly)

	print(rank, tax_id, sci_name, sep='\t')


	

	def find_genus(sci_name):
		genus = sci_name.split()

		for i in range(len(genus)):
			if genus[i] not in banned_words:
				return(genus[i])
		return(None)

	genus = find_genus(sci_name)

	if genus:

		genus = genus.replace("[", '').replace("]", "")

		genera.add(genus)
print()
print()
print("Genera:")
genera = list(genera)
genera.sort()

with open("01out-fungal_genera.txt", 'w') as outf:
	for genus in genera:
		print(genus)
		print(genus, file=outf)


print(len(genera), "genera found")





