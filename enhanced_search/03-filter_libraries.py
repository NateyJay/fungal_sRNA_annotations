
import os
import sys
from pprint import pprint
from os.path import isfile
from subprocess import Popen, PIPE
# from bs4 import BeautifulSoup
from pathlib import Path
import re

from tqdm import tqdm


from functions import *


problematic_genera = [
	'Melanogaster',
	'Tuber'
]


with open("00out-fungal_genera.txt", 'r') as f:
	fungal_genera = f.readlines()
fungal_genera = [g.strip() for g in fungal_genera]
fungal_genera = [g for g in fungal_genera if g not in problematic_genera]
fungal_genera = set(fungal_genera)








class projectClass():
	def __init__(self, header, line):

		self.header = header
		self.line = line

		self.pattern_d = {
			"genera" : "|".join(fungal_genera),
			"fungi" : "fungi|fungus|fungal",
			"sRNA" : "((s|si|mi|micro|mil|sm|small |small)RNA[s]?)"
		}


		self.project_entries = [
			'[bioproject] Project_Title',
			'[bioproject] Project_Description',
			'[gds] GSE_title',
			'[gds] GSE_summary',
			'[gds] GPL_id',
			'[sra] Study_name'
		]


		self.library_entries = [
			'[gds] GSM_title',
			'[gds] GPL_id',
			'[gds] taxon',
			'[gds] gdsType',
			'[sra] Experiment_name',
			'[sra] LIBRARY_CONSTRUCTION_PROTOCOL',
			'[sra] LIBRARY_NAME',
			'[sra] LIBRARY_SELECTION',
			'[sra] LIBRARY_SOURCE',
			'[sra] LIBRARY_STRATEGY',
			'[sra] Platform',
			'[sra] ScientificName',
			'[sra] run_count',
			'[sra] total_spots',
			'[sra] CreateDate',
			'[biosample] Title',
			'[biosample] Taxonomy',
			'[biosample] Organism',
			'[biosample] source_name',
			'[biosample] sample_name',
			'[biosample] age',
			'[biosample] dev_stage',
			'[biosample] ecotype',
			'[biosample] genotype'
		]


		self.publication_entries = [
			'[pubmed] Title'
		]

		self.keywords = {}


	def get_string(self, scale):

		def get_values(line, names):
			indicies = [i for i,h in enumerate(self.header) if h in names]
			out = [line[i] for i in indicies]
			out = " ".join(out)
			return(out)

		if scale == 'project':
			string = get_values(self.line, self.project_entries)

		elif scale == 'library':
			string = get_values(self.line, self.library_entries)

		elif scale == 'publication':
			pmid = self.line[4]
			pubmed_d = parse_pubmed_esummary_xml(f"./xmls/{pmid}.esummary.xml")
			if pubmed_d:
				pubmed_d = list(pubmed_d.values())[0]
				string = get_values(self.line, self.publication_entries) + " " + get_full_text(pubmed_d, return_text=True)
			else:
				string = get_values(self.line, self.publication_entries)

		return(string)


	def get_matches(self):

		for pattern in self.pattern_d.keys():
			for scale in ['library','publication','project']:

				key = f"{pattern}_{scale}"

				if scale == 'library' or key not in self.keywords:

					string = self.get_string(scale)
					matches = re.findall(self.pattern_d[pattern], string, re.IGNORECASE)

					# print(key)
					# print(" ", string)
					# print(" ", matches)

					if not matches:
						matches = set()

					# else:
					# 	print(matches)
					# 	print(type(matches[0]))
					# 	input()

					elif type(matches[0]) is tuple:
						matches = [m[0] for m in matches]



					try:
						self.keywords[key].update(set(matches))
					except KeyError:
						self.keywords[key] = set(matches)

	def aggregate(self):
		out = []
		for pattern in self.pattern_d.keys():
			s = set()
			for scale in ['library','publication','project']:

				key = f"{pattern}_{scale}"

				s.update(self.keywords[key])

			out.append(s)
		return(out)



p = Popen(['wc', '-l', '02out-output_table.txt'], stdout=PIPE, stderr=PIPE, encoding='utf-8')
out, err = p.communicate()

total_libraries = int(out.strip().split()[0]) - 1


print(f"{total_libraries:,} libraries to process")

bioproject_pass_d = {}

pbar = tqdm(total=total_libraries)

with open("02out-output_table.txt", 'r') as f:
	header = f.readline().strip().split("\t")


	for i,line in enumerate(f):
		# if i > 1000:
		# 	break
		pbar.update(1)
		# if i%10 == 0:
		# 	print(".", end='', flush=True)
		# if i%100 == 0:
		# 	print(" ", end='', flush=True)
		# if i%1000 == 0:
		# 	print("")

		line = line.strip().split("\t")

		id_d = {}
		for i,h in enumerate(header[:7]):
			id_d[h] = line[i]


		# pprint(id_d)
		# pprint(header)



		if id_d['bioproject'] not in bioproject_pass_d:
			bioproject_pass_d[id_d['bioproject']] = projectClass(header, line)


		bioproject_pass_d[id_d['bioproject']].get_matches()

		# print(line)
		# pprint(bioproject_pass_d[id_d['bioproject']].keywords)
		# input()





pbar.close()


total_bioprojects = len(list(bioproject_pass_d.keys()))
print()

filtered_bioprojects = set()

pbar = tqdm(total=total_libraries)
with open("03out-output_table.keywords.txt", 'w') as outf:

	with open("02out-output_table.txt", 'r') as f:
		header = f.readline().strip().split("\t")


		def get_values(line, names):
			indicies = [i for i,h in enumerate(header) if h in names]
			out = [line[i] for i in indicies]
			out = " ".join(out)
			return(out)



		new_entries = [
			'[filter] genus',
			'[filter] fungi',
			'[filter] sRNAs'
		]

		header = header[:7] + new_entries + header[7:]

		print("\t".join(header), file=outf)


		for line in f:
			pbar.update(1)

			line = line.strip().split("\t")
			id_d = {}
			for i,h in enumerate(header[:7]):
				id_d[h] = line[i]

			bioproject = id_d['bioproject']

			filters = bioproject_pass_d[bioproject].aggregate()


			if (filters[0] != set() or filters[1] != set()) and filters[2] != set():
				filters = [", ".join(fil) for fil in filters]
				filtered_bioprojects.add(bioproject)
				line = line[:7] + filters + line[7:]

				print('\t'.join(line), file=outf)

pbar.close()

print(f"{len(filtered_bioprojects):,} passing filter")


























