

import sys

from pprint import pprint, pformat
import os

from pathlib import Path
from os.path import isfile, isdir, getsize

from subprocess import Popen, PIPE


from bs4 import BeautifulSoup

from collections import Counter

from copy import deepcopy
import re

from functions import *



def search_bioproject(bpj, force = False):


	# files = os.listdir(directory)


	out_file =  f"xmls/{bpj}.bioproject.esummary.xml"


	if not isfile(out_file) or force:

		call = f"esearch -db bioproject -query {bpj} | esummary > temp.xml"
		print("  🔗 ", call)

		p = Popen(call, shell=True, stdout=PIPE, stderr=PIPE)
		p.communicate()
		os.rename("temp.xml", out_file)



	link_file = f"xmls/{bpj}.links.xml"


	if not isfile(link_file) or force or os.stat(link_file).st_size == 0:
		call = f"elink -db bioproject -id {bpj} -cmd acheck > temp.xml"
		print("  🔗 ", call)
		p = Popen(call, shell=True, stdout=PIPE, stderr=PIPE)
		p.communicate()
		os.rename("temp.xml", link_file)

	to_dbs = []
	with open(link_file, 'r') as f:
		for line in f:
			line = line.strip()
			# print(line)
			if "<DbTo>" in line:
				to_db = line.split(">")[1].split("<")[0]
				to_dbs.append(to_db)
	# print(to_dbs)
	to_dbs = [t for t in to_dbs if t in ['biosample', 'sra','gds', 'pubmed']]
	to_dbs = list(set(to_dbs))
	to_dbs.sort()

	print()
	print(bpj)
	print(f"  databases: {to_dbs}")

	if "sra" not in to_dbs:

		print(f"    {bpj} lacking sra -> skip")
		#bpjs_without_sra.add(bpj)

	else:

		for to_db in to_dbs:
			print(f"    {to_db} ", end='')#, flush=True)

			for retmode in ['esummary']:

				print(f"-> {retmode} ", end='')#, flush=True)
				out_file = f"xmls/{bpj}.{to_db}.{retmode}.xml"
				if not isfile(out_file) or force:
					call = f"esearch -db bioproject -query {bpj} | elink -target {to_db} | {retmode} > temp.xml"
					print("\n  🔗 ", call)

					p = Popen(call, shell=True, stdout=PIPE, stderr=PIPE)
					p.communicate()
					os.rename("temp.xml", out_file)

				if to_db == 'sra':

					with open(out_file, 'r') as tempf:
						soup = BeautifulSoup(tempf, 'xml')

					if len(soup.find_all("DocumentSummary")) > 5000:
						print("removed due to > 5,000 entries!")
						return




				if to_db == "gds":
					gsm_file = f"xmls/{bpj}.gsm.{retmode}.xml"
					# print(gsm_file)
					print(f"-> gsm esearch ", end='')#, flush=True)

					if not isfile(gsm_file) or force:
						with open(out_file, 'r') as f:
							for line in f:
								if "<Accession>GSE" in line:
									# print(line)
									gse = line.split(">")[1].split("<")[0]

									call = f"esearch -db gds -query {gse} | {retmode} > temp.xml"
									print("\n  🔗 ", call)
									p = Popen(call, shell=True, stdout=PIPE, stderr=PIPE)
									p.communicate()
									os.rename("temp.xml", gsm_file)


			print()
		print()



def run_searches():


	bpj_to_pmid = {
		'elink' : {},
		'full_text' : {}
	}

	bpjs = set()


	with open(f"01out-link_bioprojects.txt", 'r') as f:
		header = f.readline()
		for line in f:
			pmid, bpj = line.strip().split("\t")

			if bpj in bpj_to_pmid['elink']:
				print(f'Warning: bioproject "{bpj}" already found in link')

			bpj_to_pmid['elink'][bpj] = pmid

			bpjs.add(bpj)


	with open(f"01out-full_text_bioprojects.txt", 'r') as f:
		header = f.readline()
		for line in f:
			pmid, bpj = line.strip().split("\t")

			try:
				bpj_to_pmid['full_text'][bpj].append(pmid)
			except KeyError:
				bpj_to_pmid['full_text'][bpj] = [pmid]

			bpjs.add(bpj)

	bpjs = list(bpjs)
	bpjs.sort()


	problematic_bpjs = [
		'PRJNA224116', # a ref seq for gagillions of species
		'PRJNA30709',  # encode project
		'PRJNA371514', # multi group study playig with library techniques
		'PRJNA63467'   # another encode project
	]

	bpjs = [b for b in bpjs if b not in problematic_bpjs]


	Path(f"xmls").mkdir(parents=True, exist_ok=True)

	out_file = f"02out-output_table.txt"

	with open(out_file, 'w') as outf:

		header = ["bioproject", "srx", 'srr', "biosample", "gsm", "pmid", "pmc"]
		# header += ['[pubmed] guess']
		header += make_pmd_line(False)[1]
		header += make_bpj_line(False, False)[1]
		header += make_gsm_line(False, False)[1]
		header += make_srx_line(False, False)[1]
		header += make_bsm_line(False, False)[1]

		print("\t".join(header), file=outf)


	# bpjs = ['PRJNA483837']
	for bpj_count, bpj_id in enumerate(bpjs):

		# if bpj_count > 15:
		# 	sys.exit()

		print()
		print()


		print(bpj_count+1, "/", len(bpjs))

		search_bioproject(bpj_id)


		bpj_dict = parse_bioproject_esummary_xml(bpj_id)
		gds_dict, gsm_to_srx, srx_to_gsm = parse_gds_esummary_xml(bpj_id)
		sra_dict = parse_sra_esummary_xml(file_name = f"xmls/{bpj_id}.sra.esummary.xml")
		bsm_dict = parse_BioSample_esummary_xml(file_name = f"xmls/{bpj_id}.biosample.esummary.xml")
		pmd_dict = parse_pubmed_esummary_xml(file_name=f"xmls/{bpj_id}.pubmed.esummary.xml", single=True)




		pprint(bpj_dict)
		pprint(gds_dict)
		pprint(sra_dict)
		pprint(bsm_dict)
		pprint(pmd_dict)


		pmc_id = None
		if pmd_dict:
			pmid   = pmd_dict['pubmed']
			pmc_id = pmd_dict['pmc']

		if not pmd_dict:

			try:
				pmid = bpj_to_pmid['elink'][bpj_id]
				pmd_dict = parse_pubmed_esummary_xml(file_name=f"xmls/{pmid}.pubmed.esummary.xml", single=True)
				if pmd_dict:
					pmc_id = pmd_dict['pmc']
				else:
					pmid = None
					pmc_id = None
			except KeyError:
				pass


		if not pmd_dict:
			try:
				recovery_pmids = bpj_to_pmid['full_text'][bpj_id]
			except KeyError:
				recovery_pmids = False

			if recovery_pmids:

				if len(recovery_pmids) == 1:
					pmid = recovery_pmids[0]
					xml_file = search_pubmed(pmid)
					pmd_dict = parse_pubmed_esummary_xml(file_name=xml_file, single=True)
					if pmd_dict:
						pmc_id = pmd_dict['pmc']
					else:
						pmid = None
						pmc_id = None

				else:
					pmid = f'possible: {recovery_pmids}'
					pmc_id = None


		# pprint(pmd_dict)






		pmd_line, pmd_fields = make_pmd_line(pmd_dict)

		if sra_dict:
			for srx_id in sra_dict.keys():
				gsm_id = sra_dict[srx_id]['GSM_id']


				if gsm_id in ['', '-']:
					try:
						gsm_id = srx_to_gsm[srx_id]
					except KeyError:
						gsm_id = '-'
					except TypeError:
						gsm_id = '-'

				if gsm_id == '':
					gsm_id = '-'


				# print(pmid_to_info[pmd_dict['pubmed']])

				# print(pmid)
				# print(pmid_to_info[pmd_dict['pubmed']])
				# genera = pmid_to_info[pmd_dict['pubmed']][-1]

				bsm_id = sra_dict[srx_id]['BioSample']

				bpj_line, bpj_fields = make_bpj_line(bpj_dict, bpj_id)
				bsm_line, bsm_fields = make_bsm_line(bsm_dict, bsm_id)
				srx_line, srx_fields = make_srx_line(sra_dict, srx_id)
				gsm_line, gsm_fields = make_gsm_line(gds_dict, gsm_id)

				try:
					srrs = sra_dict[srx_id]['run_list']
				except KeyError:
					srrs = '-'

				srrs = srrs.split(',')

				for srr in srrs:



					line = [bpj_id, srx_id, srr, bsm_id, gsm_id, pmid, pmc_id]
					# line += [str(guess_pmd)]
					line += pmd_line + bpj_line + gsm_line + srx_line + bsm_line



					with open(out_file, 'a') as outf:
						print("\t".join(map(str, line)), file=outf)

					# sys.exit()


log_file = f"02out-log.txt"
sys.stdout = Logger(log_file)





## Adding non-fungal bioprojects


# bpjs_to_add = [
# "PRJNA776736", # Oryza sativa
# "PRJNA807525", # Drosophila melanogaster
# "PRJNA839379", # Caenorhabditis
# "PRJNA934562", # Arabidopsis
# "PRJNA875132", # Arabidopsis
# "PRJNA431815", # Botrytis
# "PRJNA978613", # Botrytis
# "PRJNA314979",
# "PRJNA314979",
# "PRJNA360412",
# "PRJNA499084",
# "PRJNA892012",
# "PRJNA193536",
# "PRJNA431815",
# "PRJNA97861",
# "PRJNA97861",
# "PRJNA628654",
# "PRJNA934070",
# "PRJNA477255",
# "PRJNA490143",
# "PRJNA264848",
# "PRJNA534364",
# "PRJNA448445",
# "PRJNA407898",
# "PRJNA549956",
# "PRJNA673414",
# "PRJNA673413",
# "PRJNA270038",
# "PRJNA499084",
# "PRJNA378525",
# "PRJNA477286", ]



# for bpj in bpjs_to_add:
# 	if bpj not in bpjs:
# 		bpjs.append(bpj)
   

# bpjs = ['PRJNA475703']


run_searches()

