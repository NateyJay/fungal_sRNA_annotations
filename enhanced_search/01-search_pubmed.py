
import os
import sys
from pprint import pprint
from os.path import isfile
from subprocess import Popen, PIPE
from bs4 import BeautifulSoup
from pathlib import Path
import re



from functions import *



force = False


Path(f"./xmls").mkdir(parents=True, exist_ok=True)

out_header = ["pubmed", "pmc", "doi", 'title','pubdate', "elink_bioprojects", "elink_other_ids", 'keyword_bioprojects', 'keyword_other_ids']
out_file = "01out-sRNA_pubs_fungi.txt"
with open(out_file, 'w') as outf:
	print("\t".join(out_header), sep='\t', file=outf)


bad_file = "01out-bad_links.txt"
with open(bad_file, "w") as outf:
	print('doi','url', 'file_name', sep='\t', file=outf)




import json
from pathlib import Path
from Bio import Entrez
Entrez.email = "nathan.johnson@umayor.cl"


log_file = f"01out-log.txt"
sys.stdout = Logger(log_file)


with open("./00out-fungal_genera.txt", 'r') as f:
	fungal_genera = f.readlines()
fungal_genera = [f.strip() for f in fungal_genera]

to_remove = [f for f in fungal_genera if len(f) < 5]

to_remove.append("Nia")
to_remove.append("Bulgaria")

print(to_remove)
# sys.exit()




def get_pubmed_ids(fungal_genera):
	id_dir = Path('01out-id_lists')
	id_dir.mkdir(parents = True, exist_ok = True)

	id_list = set()

	fungal_genera = ['fungi'] + fungal_genera


	chunk_size = 4

	for chunk in range(0, len(fungal_genera), chunk_size):
		chunk = list(range(chunk, chunk+chunk_size))
		term = '('
		for i in chunk:
			try:
				genus = fungal_genera[i]
			except IndexError:
				break

			if genus in to_remove:
				continue

			if i > 0:
				term += ' OR '

			if genus == 'fungi':
				term += '\\\"Fungi\\\"[WORD] OR \\\"Fungus\\\"[WORD] OR \\\"Fungal\\\"[WORD]'
			else:
				term += f'\\\"{genus}\\\"'

		term += ') AND (\\\"miRNA*\\\"[WORD] OR \\\"microRNA*\\\"[WORD] OR \\\"milRNA*\\\"[WORD] OR \\\"small RNA*\\\"[WORD] OR \\\"sRNA*\\\"[WORD] OR \\\"siRNA*\\\"[WORD] OR \\\"smRNA*\\\"[WORD] OR \\\"epigen*\\\"[WORD] OR \\\"RNAi\\\"[WORD]) NOT Review[PTYP] NOT Book[PTYP]'

		# print(term)
		# sys.exit()
		chunk_name = f'{min(chunk)}-{max(chunk)}'

		id_file = Path(id_dir, f'{chunk_name}.txt')

		if id_file.is_file():
			with open(id_file, 'r') as f:
				i=0
				for line in f:
					i += 1
					id_list.add(line.strip())

				print(i, chunk_name, ", ".join(fungal_genera[min(chunk):max(chunk)]), sep='\t')


				for g in fungal_genera[min(chunk):max(chunk)]:
					if g in to_remove:
						print("    ", g, "<- banned!")

				if '28223318' in id_list:
					print("   ^^^ bad found!!" )
					sys.exit()
			continue

		handle = Entrez.esearch(db='pubmed', term=term, RetMax = 10000)
		record = Entrez.read(handle)

		# print(record)
		handle.close()

		# print(int(record["Count"]))
		genus_ids = record['IdList']


		if len(genus_ids) == 10000:
			sys.exit("AT RETMAX ")

		with open(id_file, 'w') as outf:
			for val in genus_ids:
				print(val, file=outf)
		id_list.update(set(genus_ids))

		print(len(genus_ids), chunk_name, ", ".join(fungal_genera[min(chunk):max(chunk)]), sep='\t')

		for g in fungal_genera[min(chunk):max(chunk)]:
			if g in to_remove:
				print("    ", g, "<- banned!")

		# sys.exit()
	print()
	print(f"{len(id_list):,} publications")

	# sys.exit()

	return(list(id_list))

def get_pubmed_summary(pubmed_ids):

	bpjs = set()

	link_file = "01out-link_bioprojects.txt"
	with open(link_file, 'w') as outf:
		print("pubmed\tbioproject", file=outf)


	full_text_file = "01out-full_text_bioprojects.txt"
	with open(full_text_file, 'w') as outf:
		print("pubmed\tbioproject", file=outf)


	doc_i = 0
	summary_dir = Path('01out-summary_dir')
	summary_dir.mkdir(parents = True, exist_ok = True)

	chunk_size = 100
	for chunk_i in range(0, len(pubmed_ids), chunk_size):
		chunk = list(range(chunk_i, chunk_i+chunk_size))

		ids = []

		for i in chunk:
			try:
				ids.append(pubmed_ids[i])
			except IndexError:
				break


		chunk_name = f"{min(chunk)}-{max(chunk)}"

		chunk_file = Path(summary_dir, f'{chunk_name}.txt')

		# print(",".join(map(str, ids)))
		# sys.exit()

		if chunk_file.is_file():
			with open(chunk_file, 'r') as f:
				record = json.load(f)
		else:
			handle = Entrez.esummary(db='pubmed', id=",".join(map(str, ids)), RetMax = 10000)
			record = Entrez.read(handle)

			# print(record)
			handle.close()

			record = list(record)



			with open(chunk_file, 'w') as outf:
				json.dump(record, outf)


		for doc in record:

			doc_i += 1

			# pprint(doc)

			doc['pubmed'] = doc['ArticleIds']['pubmed'][0]

			try:
				doc['pmc'] = doc['ArticleIds']['pmc']
			except KeyError:
				doc['pmc'] = None

			try:
				doc['doi'] = doc['ArticleIds']['doi']
			except KeyError:
				doc['doi'] = None

			try:
				doc['pii'] = doc['ArticleIds']['pii']
			except KeyError:
				doc['pii'] = None


			print()
			print()
			print(f"{doc_i} / {len(pubmed_ids)}")
			print("PMID:", doc['pubmed'])
			print("pmc:", doc['pmc'])
			print("doi:", doc['doi'])
			print("Title:", doc['Title'])
			print("Date:", doc['PubDate'])
			print("FullJournalName:", doc['FullJournalName'])


			if int(doc['PubDate'].split(" ")[0]) <= 2011:
				print('SKIPPED - TOO OLD')
				continue

			if 'amyloid' in doc['Title'].lower():
				print('SKIPPED - LIKELY OFF TOPIC (amyloid)')
				continue


			link_ids = set(search_links(doc['pubmed']))

			print()
			print("  Pubmed elink to all:")
			for i in link_ids:
				print("    ", i)


			full_text_ids = get_full_text(doc)

			print("  full_text:")

			for i in full_text_ids:
				print("    ", i)

			link_bioprojects = [f for f in link_ids if f.startswith(('PRJNA','PRJEB','PRJDB'))]

			if not link_bioprojects:
				link_ids = list(link_ids)
				to_add = []
				for i in link_ids:

					if not i.startswith(('PRJNA','PRJEB','PRJDB')):
						to_add += elink_to_bpj(i)

				link_ids += to_add

				link_ids      = [f for f in link_ids if f.startswith(('PRJNA','PRJEB','PRJDB'))]
				link_ids = set(link_ids)

			else:
				link_ids = set(link_bioprojects)




			to_add = []
			for i in full_text_ids:

				if not i.startswith(('PRJNA','PRJEB','PRJDB')):
					to_add += elink_to_bpj(i)

			full_text_ids += to_add

			full_text_ids = [f for f in full_text_ids if f.startswith(('PRJNA','PRJEB','PRJDB'))]
			full_text_ids = set(full_text_ids)


			for i in full_text_ids:
				print(f"    {i}*")


			with open(link_file, 'a') as outf:
				for i in link_ids:
					print(doc['pubmed'], i, sep='\t', file=outf)
					bpjs.add(i)

			if len(full_text_ids) <= 3:
				with open(full_text_file, 'a') as outf:
					for i in full_text_ids:
						# print(i)
						print(doc['pubmed'], i, sep='\t', file=outf)
						bpjs.add(i)

	expected_bioprojects = [
		"PRJDB4589",
		"PRJDB5894",
		"PRJEB24307",
		"PRJEB28454",
		"PRJEB29180",
		"PRJEB35457",
		"PRJNA123555",
		"PRJNA136103",
		"PRJNA140539",
		"PRJNA154129",
		"PRJNA185495",
		"PRJNA190099",
		"PRJNA193535",
		"PRJNA193536",
		"PRJNA193537",
		"PRJNA196947",
		"PRJNA201504",
		"PRJNA205464",
		"PRJNA207075",
		"PRJNA207279",
		"PRJNA213313",
		"PRJNA232807",
		"PRJNA235985",
		"PRJNA251991",
		"PRJNA253151",
		"PRJNA253747",
		"PRJNA254525",
		"PRJNA258226",
		"PRJNA259172",
		"PRJNA261827",
		"PRJNA264848",
		"PRJNA268267",
		"PRJNA270038",
		"PRJNA270085",
		"PRJNA271281",
		"PRJNA278408",
		"PRJNA282111",
		"PRJNA289147",
		"PRJNA290002",
		"PRJNA291314",
		"PRJNA294170",
		"PRJNA301367",
		"PRJNA304218",
		"PRJNA305725",
		"PRJNA306627",
		"PRJNA311278",
		"PRJNA317629",
		"PRJNA322006",
		"PRJNA322114",
		"PRJNA322180",
		"PRJNA322451",
		"PRJNA322513",
		"PRJNA326123",
		"PRJNA329032",
		"PRJNA342612",
		"PRJNA347833",
		"PRJNA350329",
		"PRJNA350403",
		"PRJNA355964",
		"PRJNA361034",
		"PRJNA368962",
		"PRJNA379694",
		"PRJNA382810",
		"PRJNA383112",
		"PRJNA384280",
		"PRJNA393690",
		"PRJNA395017",
		"PRJNA407898",
		"PRJNA408312",
		"PRJNA413773",
		"PRJNA42807",
		"PRJNA429556",
		"PRJNA431815",
		"PRJNA448380",
		"PRJNA450159",
		"PRJNA453739",
		"PRJNA475703",
		"PRJNA476756",
		"PRJNA477255",
		"PRJNA477286",
		"PRJNA480504",
		"PRJNA480952",
		"PRJNA481323",
		"PRJNA483837",
		"PRJNA486707",
		"PRJNA487111",
		"PRJNA487537",
		"PRJNA490143",
		"PRJNA496418",
		"PRJNA499084",
		"PRJNA508370",
		"PRJNA511629",
		"PRJNA514312",
		"PRJNA517599",
		"PRJNA526042",
		"PRJNA530565",
		"PRJNA534364",
		"PRJNA542139",
		"PRJNA549956",
		"PRJNA557604",
		"PRJNA558429",
		"PRJNA559095",
		"PRJNA560364",
		"PRJNA560456",
		"PRJNA562787",
		"PRJNA565611",
		"PRJNA565629",
		"PRJNA576793",
		"PRJNA578811",
		"PRJNA600940",
		"PRJNA638238",
		"PRJNA647397",
		"PRJNA659617",
	]

	for b in expected_bioprojects:
		print(b, end='\t')
		if b in bpjs:
			print("x")
		else:
			print()



		# sys.exit()


pubmed_ids = get_pubmed_ids(fungal_genera)


# get_pubmed_summary(['33975967'])
pubmed_summary = get_pubmed_summary(pubmed_ids)















