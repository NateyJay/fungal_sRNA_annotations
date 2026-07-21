

import sys
from pprint import pprint
import os
from pathlib import Path
from os.path import isfile
from subprocess import Popen, PIPE
from bs4 import BeautifulSoup
import re

directory = "."

ids = []
bpj_ids = []

articles_with_ids = 0
articles = 0

with open('01out-sRNA_pubs_fungi.txt', 'r') as f:
	header = f.readline().strip("\n").split('\t')
	print(header)

	bpj_index = header.index("bioprojects")
	all_ids_index = header.index("all_identifiers")
	print(bpj_index)
	print(all_ids_index)

	for line in f:
		articles += 1
		line = line.strip().split('\t')

		line = [l.strip('"') for l in line]

		print(line)

		if line[bpj_index] != '-':
			articles_with_ids += 1
			bpj_ids += line[bpj_index].split(", ")


		elif line[all_ids_index] != '-':
			articles_with_ids += 1
			ids += line[all_ids_index].split(", ")



# sys.exit()

# pprint(sorted(ids))

sra_ids = [i for i in ids if i.startswith(('SRR', 'SRP', 'SRX', 'SRA', 'ERR','ERP'))]
bsm_ids = [i for i in ids if i.startswith(('SAMN'))]
gds_ids = [i for i in ids if i.startswith(('GSM', 'GSE'))]
# bpj_ids = [i for i in ids if i.startswith(('PRJNA', 'PRJEB'))]

sra_ids = list(set(sra_ids))
bsm_ids = list(set(bsm_ids))
gds_ids = list(set(gds_ids))
bpj_ids = list(set(bpj_ids))



# print(len(bpj_ids), "bpj_ids")
# print(len(sra_ids + bsm_ids + gds_ids), 'other ids')
# print(len(ids) - len(sra_ids + bsm_ids + gds_ids))

# for i in ids:
# 	if i not in sra_ids + bpj_ids + gds_ids + bsm_ids:
# 		print(i)
# sys.exit()

Path(f"{directory}/xmls").mkdir(parents=True, exist_ok=True)


def elink_to_bpj(identifier, db, force = False):

	out_file =  f"{directory}/xmls/{identifier}.elink.xml"

	if not isfile(out_file) or force:

		call = f"esearch -db {db} -query '{identifier}' | elink -target bioproject | esummary > temp.xml"
		print("  🔗 ", call)

		p = Popen(call, shell=True, stdout=PIPE, stderr=PIPE)
		p.communicate()
		os.rename("temp.xml", out_file)

	return(out_file)



files = []

print(f"searching from sra")
for i in sra_ids:
	print(" ", i)
	files.append(elink_to_bpj(i, 'sra'))

# print(f"searching from bioproject")
# for i in bpj_ids:
# 	print(i)
# 	elink_to_bpj(i, 'bioproject')

print(f"searching from biosample")
for i in bsm_ids:
	print(" ", i)
	files.append(elink_to_bpj(i, 'biosample'))

print(f"searching from gds")
for i in gds_ids:
	print(" ", i)
	files.append(elink_to_bpj(i, 'gds'))


print(" ")
print("Parsing bioprojects...")


def try_get_text(soup, container):
	try:
		return(soup.find(container).get_text())
	except:
		return(False)

for file in files:
	with open(file,'r') as f:
		soup = BeautifulSoup(f, 'xml')
		

		acc = try_get_text(soup, 'Project_Acc')

		if acc:
			bpj_ids.append(acc)


print(f"input {articles} articles")
print(f"   {articles_with_ids} have an ID associated")
print()
print(len(bpj_ids), 'bioprojects found')


bpj_ids = list(set(bpj_ids))
print(len(bpj_ids), 'de-duplicated')

with open("02out-all_bpjs.txt", 'w') as outf:
	for i in bpj_ids:
		print(i, file=outf)




