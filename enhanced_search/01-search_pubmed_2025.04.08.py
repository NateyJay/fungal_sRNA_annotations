
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




def wide_article_search(term, force = False):
	# files = os.listdir(directory)

	# term = term.rstrip("'").lstrip("'").replace("'", '"')
	# out_file = "01out-pubmed_merged.xml"
	# if isfile(out_file) and not force:
	# 	return(out_file)

	def search(term, db, force=False, out_file=False):

		if not out_file:
			out_file =  f"./01out-{db}.xml"

		if not isfile(out_file) or force:

			call = f"esearch -db {db} -query \"{term}\" | esummary > temp.xml"
			# print("  🔗 ", call)
			print(f"  🔗 making {out_file}")
			# print()
			# print(call)

			p = Popen(call, shell=True, stdout=PIPE)
			p.communicate()


			### cleaning up problems with mulitple sets

			with open("temp.xml", 'r') as f:
				with open(out_file, 'w') as outf:
					outf.write(f.readline())
					outf.write(f.readline())
					outf.write("<TopLevel>")
					for line in f:
						outf.write(line)
					outf.write("</TopLevel>")
			os.remove('temp.xml')

		return(out_file)

	return(search(term, 'pubmed', force=force))

	# pmids = set()

	# pmc_file = search(term, 'pmc')
	# pubmed_file = search(term, 'pubmed')


	# for file in [pmc_file, pubmed_file]:

	# 	print(file)

	# 	with open(file, 'r') as f:
	# 		soup = BeautifulSoup(f, 'xml')

	# 	for aid in soup.find_all("ArticleId"):
	# 		if aid.find("IdType").text == 'pmid':
	# 			pmid = aid.find('Value').text
	# 			if pmid != '0':
	# 				pmids.add(pmid)


	# pmids = list(pmids)
	# print(f"searching merged pubmed for {len(pmids):,} papers")
	# out_file = search(",".join(pmids), 'pubmed', out_file=out_file, force=True)

	# return(out_file)

def main(term, force):




	bpj_to_pubmed = {}

	bpjs = set()

	pubmed_xml = wide_article_search(term, force)
	print("parsing pubmed search...")
	parsed_pubmed = parse_pubmed_esummary_xml(file_name=pubmed_xml)

	total_docs = len(list(parsed_pubmed.keys()))

	print(f"{len(parsed_pubmed):,} pubmed entries found")

	keys = list(parsed_pubmed.keys())
	for key in keys:
		if int(parsed_pubmed[key]['PubDate'].split(" ")[0]) <= 2009:
			del parsed_pubmed[key]
	print(f"{len(parsed_pubmed):,} newer than 2009")


	link_file = "01out-link_bioprojects.txt"
	with open(link_file, 'w') as outf:
		print("pubmed\tbioproject", file=outf)


	full_text_file = "01out-full_text_bioprojects.txt"
	with open(full_text_file, 'w') as outf:
		print("pubmed\tbioproject", file=outf)


	# parsed_pubmed = {'30231028' : parsed_pubmed['30231028']}


	for doc_i, pubmed_dict in enumerate(parsed_pubmed.values()):

		print()
		print()
		print(f"{doc_i+1} / {len(parsed_pubmed)}")
		print("PMID:", pubmed_dict['pubmed'])
		print("pmc:", pubmed_dict['pmc'])
		print("doi:", pubmed_dict['doi'])
		print("Title:", pubmed_dict['Title'])
		print("Date:", pubmed_dict['PubDate'])
		print("FullJournalName:", pubmed_dict['FullJournalName'])




		link_ids = set(search_links(pubmed_dict['pubmed']))

		print()
		print("  Pubmed elink to all:")
		for i in link_ids:
			print("    ", i)

		# pubmed_dict['elink_bioprojects'] += [i for i in link_ids if i.startswith(('PRJNA','PRJEB', 'PRJDB'))]
		# pubmed_dict['elink_other_ids']   += [i for i in link_ids if not i.startswith(('PRJNA','PRJEB', 'PRJDB'))]


		# if pubmed_dict['pmc']:

			# pmc_xml = search_pmc(pubmed_dict['pmc'])
			# efetch_ids = parse_pmc_efetch_xml(pmc_xml)

			# print("  PMC efetch:")
			# for i in efetch_ids:
			# 	print("    ", i)

		full_text_ids = get_full_text(pubmed_dict)

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
				print(pubmed_dict['pubmed'], i, sep='\t', file=outf)
				bpjs.add(i)

		if len(full_text_ids) <= 3:
			with open(full_text_file, 'a') as outf:
				for i in full_text_ids:
					# print(i)
					print(pubmed_dict['pubmed'], i, sep='\t', file=outf)
					bpjs.add(i)


		# print(bpjs)




	sys.exit()
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
	# 	sys.exit()



	# 	if not doc_dict['elink_bioprojects'] and doc_dict['elink_other_ids']:
	# 		for i in doc_dict['elink_other_ids']:
	# 			doc_dict['elink_bioprojects'] += elink_to_bpj(i)






	# 	# pubmed_ids = get_identifier(doc.prettify())

	# 	# print("  Pubmed esummary:")
	# 	# for i in pubmed_ids:
	# 	# 	print("    ", i)


	# 	new_enough = int(doc_dict['PubDate'].split(" ")[0]) > 2009


	# 	## Getting full texts

	# 	efetch_ids = []
	# 	scrape_ids = []
	# 	doi_ids    = []

	# 	if doc_dict['pmc'] != "-" and new_enough:

	# 		pmc_id = doc_dict['pmc']
	# 		pmc_xml = search_pmc(pmc_id)
	# 		efetch_ids = parse_pmc_efetch_xml(pmc_xml)

	# 		print("  PMC efetch:")
	# 		for i in efetch_ids:
	# 			print("    ", i)


	# 		scrape_ids = scrape_pmc(pmc_id)

	# 		print("  PMC scrape:")
	# 		for i in scrape_ids:
	# 			print("    ", i)

	# 	if doc_dict['doi'] != '-' and new_enough:

	# 		print("  doi scrape:")
	# 		doi_ids = scrape_doi(doc_dict['doi'], doc_dict['pubmed'], doc_dict['pii'])

	# 		for i in doi_ids:
	# 			print("    ", i)

	# 	text_ids = efetch_ids + scrape_ids + doi_ids
	# 	text_ids = list(set(text_ids))

	# 	doc_dict['keyword_bioprojects'] += [i for i in text_ids if i.startswith(('PRJNA','PRJEB', 'PRJDB'))]
	# 	doc_dict['keyword_other_ids']   += [i for i in text_ids if not i.startswith(('PRJNA','PRJEB', 'PRJDB'))]


	# 	if not doc_dict['keyword_bioprojects'] and doc_dict['keyword_other_ids']:
	# 		for i in doc_dict['keyword_other_ids']:
	# 			doc_dict['keyword_bioprojects'] += elink_to_bpj(i)




	# 	# ids = efetch_ids + scrape_ids + link_ids + pubmed_ids + doi_ids
	# 	# ids = list(set(ids))




	# 	# ## Getting bioprojects based on other identifiers

	# 	# bioproject_ids = [i for i in ids if i.startswith(('PRJNA','PRJEB', 'PRJDB'))]
	# 	# non_bioproject_ids = [i for i in ids if not i.startswith(('PRJNA','PRJEB', 'PRJDB'))]


	# 	# if len(bioproject_ids) == 0 and len(non_bioproject_ids) > 0:
	# 	# 	for i in non_bioproject_ids:
	# 	# 		elink_to_bpj(i)



	# 	full_texts = []

	# 	if doc_dict['pmc'] != '-' and new_enough:
	# 		full_texts.append(f"{directory}/xmls/{pmc_id}.scrape.html")

	# 	if doc_dict['doi'] != '-' and new_enough:
	# 		full_texts.append(f"{directory}/xmls/PMID{doc_dict['pubmed']}.doi.scrape.html")



	# 	## catching any hits for fungal genera
	# 	## and
	# 	## catching any sRNA keywords:

	# 	# genera_hits = []
	# 	# sRNA_hits   = []

	# 	# sRNA_pattern = "(s|si|mi|micro|mil|sm)RNA[s]?"

	# 	# for text_file in full_texts:
	# 	# 	if isfile(text_file):
	# 	# 		with open(text_file, 'r') as textf:
	# 	# 			raw = textf.read()

	# 	# 		print(raw)
	# 	# 		z = re.match(sRNA_pattern, raw)
	# 	# 		if z:
	# 	# 			print((z.groups()))
	# 	# 			sys.exit()

	# 	# 		print(z)
	# 	# 		input()


	# 	# 		raw = set(raw.split())

	# 	# 		genera_hits += [g for g in genera if g in raw]


	# 	# if sRNA_hits != []:
	# 	# 	print(sRNA_hits)
	# 	# 	sys.exit()




	# 	doc_dict['elink_bioprojects']   = list(set(doc_dict['elink_bioprojects']))
	# 	doc_dict['elink_other_ids']     = list(set(doc_dict['elink_other_ids']))
	# 	doc_dict['keyword_bioprojects'] = list(set(doc_dict['keyword_bioprojects']))
	# 	doc_dict['keyword_other_ids']   = list(set(doc_dict['keyword_other_ids']))

	# 	if new_enough:
	# 		## writing to a file
	# 		with open(out_file, 'a') as outf:

	# 			out_line = [doc_dict['pubmed'], doc_dict['pmc'], doc_dict['doi'], doc_dict['Title'], doc_dict['PubDate']]

	# 			# out_line += [", ".join([i for i in ids if i.startswith(('PRJNA','PRJEB', 'PRJDB'))])]
	# 			# out_line += [", ".join(ids)]
	# 			out_line += [", ".join(doc_dict['elink_bioprojects'])]
	# 			out_line += [", ".join(doc_dict['elink_other_ids'])]
	# 			out_line += [", ".join(doc_dict['keyword_bioprojects'])]
	# 			out_line += [", ".join(doc_dict['keyword_other_ids'])]
	# 			# out_line += [", ".join(genera_hits)]

	# 			for i,j in enumerate(out_line):
	# 				if j == '':
	# 					out_line[i] = '-'


	# 			print("\t".join(out_line), file=outf)


	# f.close()






log_file = f"01out-log.txt"
sys.stdout = Logger(log_file)


with open("./00out-fungal_genera.txt", 'r') as f:
	fungal_genera = f.readlines()
fungal_genera = [f.strip() for f in fungal_genera]


fungal_genera = [f'\\\"{f}\\\"' for f in fungal_genera]
fungal_genera = " OR ".join(fungal_genera)



# esearch -db pubmed -"(Fungi[Text Word] OR Fungus[Text Word] OR Fungal[Text Word]) AND (miRNA OR microRNA OR milRNA OR small RNA OR sRNA OR siRNA) NOT Review[Publication Type]"

# term = "(\\\"Fungi\\\"[WORD] OR \\\"Fungus\\\"[WORD] OR \\\"Fungal\\\"[WORD]) AND (\\\"miRNA\\\"[WORD] OR \\\"microRNA\\\"[WORD] OR \\\"milRNA\\\"[WORD] OR \\\"small RNA\\\"[WORD] OR \\\"sRNA\\\"[WORD] OR \\\"siRNA\\\"[WORD] OR \\\"smRNA\\\"[WORD]) NOT Review[PTYP]"

term = "(\\\"Fungi\\\"[WORD] OR \\\"Fungus\\\"[WORD] OR \\\"Fungal\\\"[WORD] OR \\\"Yeast*\\\"[WORD]) AND (\\\"miRNA*\\\"[WORD] OR \\\"microRNA*\\\"[WORD] OR \\\"milRNA*\\\"[WORD] OR \\\"small RNA*\\\"[WORD] OR \\\"sRNA*\\\"[WORD] OR \\\"siRNA*\\\"[WORD] OR \\\"smRNA*\\\"[WORD]) NOT Review[PTYP] NOT Book[PTYP]"

term = "(\\\"Fungi\\\"[WORD] OR \\\"Fungus\\\"[WORD] OR \\\"Fungal\\\"[WORD]) AND (\\\"miRNA*\\\"[WORD] OR \\\"microRNA*\\\"[WORD] OR \\\"milRNA*\\\"[WORD] OR \\\"small RNA*\\\"[WORD] OR \\\"sRNA*\\\"[WORD] OR \\\"siRNA*\\\"[WORD] OR \\\"smRNA*\\\"[WORD]) NOT Review[PTYP] NOT Book[PTYP]"

term = f"({fungal_genera} OR \\\"Fungi\\\"[WORD] OR \\\"Fungus\\\"[WORD] OR \\\"Fungal\\\"[WORD]) AND (\\\"miRNA*\\\"[WORD] OR \\\"microRNA*\\\"[WORD] OR \\\"milRNA*\\\"[WORD] OR \\\"small RNA*\\\"[WORD] OR \\\"sRNA*\\\"[WORD] OR \\\"siRNA*\\\"[WORD] OR \\\"smRNA*\\\"[WORD]) NOT Review[PTYP] NOT Book[PTYP]"

term = f"({fungal_genera} OR \\\"Fungi\\\"[WORD] OR \\\"Fungus\\\"[WORD] OR \\\"Fungal\\\"[WORD]) AND (\\\"miRNA*\\\"[WORD] OR \\\"microRNA*\\\"[WORD] OR \\\"milRNA*\\\"[WORD] OR \\\"small RNA*\\\"[WORD] OR \\\"sRNA*\\\"[WORD] OR \\\"siRNA*\\\"[WORD] OR \\\"smRNA*\\\"[WORD] OR \\\"epigen*\\\"[WORD] OR \\\"RNAi\\\"[WORD]) NOT Review[PTYP] NOT Book[PTYP]"


# print("Query:")


# sys.exit()
# term = "(Fungi[Text Word] OR Fungus[Text Word] OR Fungal[Text Word]) AND (miRNA OR microRNA OR milRNA OR small RNA OR sRNA OR siRNA) NOT Review[Publication Type]"



# term = '(“Fungi”[Text Word] OR “Fungus”[Text Word] OR “Fungal”[Text Word]) AND (“miRNA” OR “milRNA” OR "miRNA-like small RNA") NOT Review[Publication Type]


# term = "Fungi NOT Review[Publication Type]"

# with open("00-get_fungi_genera/01out-fungal_genera.txt", 'r') as f:
# 	fungal_genera = f.readlines()
# fungal_genera = [g.strip() for g in fungal_genera]
# fungal_genera = set(fungal_genera)



main(term, force=False)

# write_to_table(parsed_pubmed)







