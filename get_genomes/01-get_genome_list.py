

import polars as pl
from pathlib import Path
from subprocess import Popen, PIPE
import sys
import json
from pprint import pprint

excel_file = Path("/Volumes/YASMA/master_table.xlsx")

df = pl.read_excel(excel_file, read_options={"header_row": 1})

df = df.filter(pl.col("project-rg") != "",)
df = df.filter(pl.col("project-rg").is_not_null(),)


organisms = df.get_column("fungi_species").to_list()

## adding species termed as "MULTIPLE"
organisms.append("Rhizophagus irregularis")
organisms.append("Funneliformis mosseae")
organisms.append("Paraglomus occultum")

organisms = list(set(organisms))
organisms.sort()


## getting rid of "MULTIPLE"
organisms.remove('MULTIPLE')


json_dir = Path('01out-jsons')
json_dir.mkdir(parents=True, exist_ok=True)

org_d = dict()


for o in organisms:
	o = " ".join(o.split()[:2])
	if "Rhodotorula" in o:
		o = 'Rhodotorula sp. JG-1b'


	if o == 'Ceratobasidium':
		abbv = "Cec01"
		o = 'Ceratobasidium sp. C01'

	elif "Rhodotorula" in o:
		abbv = "Rhjg1"
		o = 'Rhodotorula sp. JG-1b'

	else:
		abbv = o.split()[0][0:2] + o.split()[1][:3]

	org_d[abbv] = o

	print(abbv, "<-", o)

print()
print()

for abbv, o in org_d.items():

	json_file = Path(json_dir, f"{abbv}.json")

	if json_file.is_file() and json_file.stat().st_size > 1:

		print(abbv, 'found')

		try:
			with open(json_file, 'r') as f:
				doc = json.load(f)
			continue

		except json.decoder.JSONDecodeError:
			print("^^^ json not functional")
			pass

	with open(json_file, 'w') as outf:

		print(abbv, 'downloading')
		# p = Popen(f"datasets summary genome taxon '{o}' --reference --report genome", shell=True, stdout=outf,
		# 	stderr=PIPE, encoding='utf-8')
		p = Popen(f"datasets summary genome taxon '{o}' --report genome", shell=True, stdout=outf,
			stderr=PIPE, encoding='utf-8')
		for e in p.stderr:
			if not e.startswith("New version of"):
				
				print(o)
				print(e.strip())

				if "but no genome data is currently available for this taxon." in e:

					print("{}", file=outf)
		p.wait()



# for abbv, o in org_d.items():

# 	json_file = Path(json_dir, f"{abbv}.json")
print()
print()

expand_abbvs = [
'Albra', 'Atrol', 'Blhor', 'Boell','Cec01','Cosub','Culun','Diseg','Fubra','Mucir','Peita','Petra','Pifer','Plery','Savan','Tacam','Vealb','Vovol'
]


with open("01out-genome_summary.tsv", 'w') as outf:
	print('abbv','organism','accession', 'assembly_name', 'assembly_level', 'refseq_category', 'paired_accession', 'submitter', 'asm_release_date', 'num_seqs', 'tot_length', 'ann_name', 'ann_release_date', 'gene_counts', file=outf, sep='\t')

	
	for abbv, organism in org_d.items():

		json_file = Path(json_dir, f"{abbv}.json")
		

		with open(json_file, 'r') as f:
			doc = json.load(f)

		if 'reports' not in doc:
			continue

		doc = doc['reports']

		for rep in doc:





			accession        = rep['accession']

			assembly_level   = rep['assembly_info']['assembly_level']
			assembly_name    = rep['assembly_info']['assembly_name']

			refseq_category  = rep['assembly_info'].get('refseq_category', None)

			submitter        = rep['assembly_info']['submitter']
			asm_release_date = rep['assembly_info']['release_date']
			tot_length       = rep['assembly_stats']['total_sequence_length']

			paired_accession = rep.get('paired_accession', '')

			for key in ['total_number_of_chromosomes', 'number_of_scaffolds', 'number_of_contigs']:
				if key in rep['assembly_stats']:
					num_seqs = rep['assembly_stats'][key]
					break

			if 'annotation_info' not in rep:
				ann_name         = ""
				ann_release_date = ""
				gene_counts      = ""

			else:
				ann_name         = rep['annotation_info']['name']
				ann_release_date = rep['annotation_info']['release_date']
				gene_counts      = rep['annotation_info']['stats']['gene_counts']['total']


			if refseq_category or abbv == 'Cec01' or abbv == 'Rhjg1' or abbv in expand_abbvs:
				print(abbv, organism, accession, assembly_name, assembly_level, refseq_category, paired_accession, submitter, asm_release_date, num_seqs, tot_length, ann_name, ann_release_date, gene_counts, sep='\t', file=outf)
				print(abbv, organism, accession, assembly_name, assembly_level, refseq_category, paired_accession, submitter, asm_release_date, num_seqs, tot_length, ann_name, ann_release_date, gene_counts, sep='\t')
			# pprint(doc)


		# if abbv == 'Rhjg1':
		# 	pprint(rep)
		# 	sys.exit()






