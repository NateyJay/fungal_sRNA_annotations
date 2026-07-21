


import sys
from pathlib import Path
from os.path import isfile, isdir, getsize
from subprocess import Popen, PIPE
import os
from bs4 import BeautifulSoup
import re
from copy import deepcopy
from requests_html import HTMLSession
import requests
from requests.exceptions import ConnectionError
from pprint import pprint


from selenium import webdriver


def get_identifier(d, bioproject_only=False):
	keys = ['PRJNA','PRJEB', 'PRJDB','SRA','ERA',"GSE", 'SRP','ERP','SRX','ERX','SAMN','SAMEA','GSM','SRR','ERR']

	if bioproject_only:
		keys = ['PRJNA','PRJEB', 'PRJDB']

	all_hits = []
	for key in keys:
		hits = re.findall(f"{key}\d+", d)
		all_hits += hits


	# all_hits = [i.strip() for i in all_hits]
	return(list(set(all_hits)))


def try_get_text(soup, container):
	try:
		return(soup.find(container).get_text())
	except:
		return(None)

def try_get_accession(soup, container, attribute):
	try:
		return(soup.find(container).attrs[attribute])
	except:
		return(None)



def search_pubmed(identifier):

	out_file =  f"./xmls/{identifier}.esummary.xml"

	if not isfile(out_file):

		call = f"esearch -db pubmed -query \"{identifier}\" | esummary > temp.xml"
		print("  🔗 ", call)

		p = Popen(call, shell=True, stdout=PIPE, stderr=PIPE)
		p.communicate()
		os.rename("temp.xml", out_file)

	return(out_file)



def search_pmc(identifier, force = False):

	out_file =  f"./xmls/{identifier}.efetch.xml"

	if not isfile(out_file) or force:

		i = identifier.lstrip("PMC")
		call = f"esearch -db pmc -query \"{i}\" | efetch -mode xml > temp.xml"
		print("  🔗 ", call)

		p = Popen(call, shell=True, stdout=PIPE, stderr=PIPE)
		p.communicate()
		os.rename("temp.xml", out_file)

	return(out_file)

def search_links(identifier, force=False):
	link_file = f"./xmls/PMID{identifier}.links.xml"

	if not isfile(link_file) or force or os.stat(link_file).st_size == 0:
		call = f"elink -db pubmed -id {identifier} -cmd acheck > temp.xml"
		print("  🔗 ", call)
		# print(call)
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

	to_dbs = [t for t in to_dbs if t in ['biosample', 'sra','gds','bioproject']]
	to_dbs = list(set(to_dbs))
	to_dbs.sort()

	# print(f"  databases: {to_dbs}")

	if to_dbs == []:
		return([])

	identifiers = []
	for to_db in to_dbs:
		# print(f"  {to_db} ", end='')#, flush=True)

		# print(f"-> esummary ", end='')#, flush=True)
		out_file = f"./xmls/PMID{identifier}.{to_db}.esummary.xml"
		if not isfile(out_file) or force:
			call = f"elink -db pubmed -id {identifier} -target {to_db} | esummary > temp.xml"
			print("  🔗 ", call)
			# print()
			# print(call)
			# print()
			p = Popen(call, shell=True, stdout=PIPE, stderr=PIPE)
			p.communicate()
			os.rename("temp.xml", out_file)



		with open(out_file, 'r') as f:
			soup = BeautifulSoup(f,'xml')
			identifiers += get_identifier(soup.prettify())


	return(identifiers)



def scrape_url(url):
	sess = HTMLSession()

	headers= {'user-agent': 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36 Edg/100.0.1185.44'}

	print("  🔗 ", url)

	try:


		response = requests.get(url, headers=headers)

		# print(response.text)


		return(response.text)

	except:
		return(None)



def java_scrape_url(url):

	print("  🔗 java ->", url)

	dr = webdriver.Chrome()
	dr.get(url)
	bs = BeautifulSoup(dr.page_source,"lxml")

	return(bs.prettify())



def get_full_text(d, force=False, return_text=False):

	# pprint(d)

	# pprint(d)
	out_file =  f"./xmls/{d['pubmed']}.full_text.html"
	# print(out_file)
	# sys.exit()


	if isfile(out_file) and not force:

		with open(out_file, 'r') as f:
			soup = BeautifulSoup(f.read(), 'xml')

	else:
		if d['pmc']:

			## try efetch first

			call = f"esearch -db pmc -query {d['pmc']} | efetch -mode xml"
			print("  🔗 ", call)

			p = Popen(call, shell=True, stdout=PIPE, stderr=PIPE, encoding='utf-8')
			out, err = p.communicate()


			soup = BeautifulSoup(out, 'xml')


			refs = soup.find("ref-list")
			if refs:
				refs.decompose()

			body = soup.find("body")


			# with open('temp.xml', 'w') as outf:
			# 	outf.write(soup.prettify())
			# print(out)
			# sys.exit()

			# nlines = len(body.prettify().split("\n"))
			# print(f"  {nlines:,} lines in body")


			# sys.exit()

			if not body:
			# input()

				url = f"https://www.ncbi.nlm.nih.gov/pmc/articles/{d['pmc']}/"
				html_text = scrape_url(url)

				soup = BeautifulSoup(html_text, features="lxml")


		else:

			url = f"https://doi.org/{d['doi']}"
			html_text = scrape_url(url)

			if "Enable JavaScript and cookies to continue" in html_text:
				html_text = java_scrape_url(url)


			paywall_words = ['Log in to view the full text', '"hasAccess":"N"', 'Access through your institution', 'access via your institution']
			for word in paywall_words:
				if word in html_text:

					print(f"  ❌ paywall: {word}")

					if d['doi'].startswith(("10.1007", "10.2478")):
						url = f"https://link-springer-com.bibliotecadigital.umayor.cl:2443/article/{d['doi']}"
					elif d['doi'].startswith("10.1126"):
						url = f"https://www-science-org.bibliotecadigital.umayor.cl:2443/doi/{d['doi']}"
					elif d['doi'].startswith('10.1038'):
						url = f"https://www-nature-com.bibliotecadigital.umayor.cl:2443/articles/{d['pii']}"
					else:
						print(f"  ❌ no url known!")
						break

					html_text = scrape_url(url)

					break


			soup = BeautifulSoup(html_text, 'html')

		try:
			with open(out_file, 'w') as outf:
				outf.write(soup.prettify())
		except RecursionError:
			return([])

	if return_text:
		return(soup.prettify())

	return(get_identifier(soup.prettify()))


def parse_full_text(pubmed):
	out_file =  f"./xmls/{pubmed}.full_text.html"

	with open(out_file, 'r') as f:
		soup = BeautifulSoup(f.read(), 'html')

# def scrape_pmc(pmc):

# 	out_file =  f"{directory}/xmls/{pmc}.scrape.html"
# 	# print(" ", out_file)

# 	if not isfile(out_file) or force:

# 		url = f"https://www.ncbi.nlm.nih.gov/pmc/articles/{pmc}/"
# 		html_text = scrape_url(url)

# 		with open(out_file, 'w') as outf:
# 			outf.write(html_text)

# 	else:
# 		# print(out_file)
# 		with open(out_file, 'r') as f:
# 			html_text = f.read()




# 	identifiers = get_identifier(html_text)

# 	return(identifiers)

# def scrape_doi(doi, pmid, pii):


# 	url = f"https://doi.org/{doi}"
# 	out_file =  f"{directory}/xmls/PMID{pmid}.doi.scrape.html"
# 	# print(" ", out_file)

# 	if not isfile(out_file) or force:

# 		html_text = scrape_url(url)

# 		with open(out_file, 'w') as outf:
# 			outf.write(html_text)

# 	else:

# 		with open(out_file, 'r') as f:
# 			html_text = f.read()



# 	if "Enable JavaScript and cookies to continue" in html_text:
# 		html_text = java_scrape_url(url)

# 		with open(out_file, 'w') as outf:
# 			outf.write(html_text)



# 	paywall_words = ['Log in to view the full text', '"hasAccess":"N"', 'Access through your institution', 'access via your institution']
# 	for word in paywall_words:
# 		if word in html_text:

# 			if doi.startswith(("10.1007", "10.2478")):
# 				new_url = f"https://link-springer-com.bibliotecadigital.umayor.cl:2443/article/{doi}"
# 			elif doi.startswith("10.1126"):
# 				new_url = f"https://www-science-org.bibliotecadigital.umayor.cl:2443/doi/{doi}"
# 			elif doi.startswith('10.1038'):
# 				new_url = f"https://www-nature-com.bibliotecadigital.umayor.cl:2443/articles/{pii}"
# 			else:
# 				new_url = "not known!"


# 			# print(html_text)
# 			with open(bad_file, 'a') as outf:
# 				print(doi, new_url, Path(out_file).name, sep='\t', file=outf)
# 			print(f'url: {url}')
# 			print(f"file: {out_file}")
# 			print(f"  ❌ paywall: {word}")
# 			# sys.exit()
# 			break
# 			# print(f"Warning: paywall word '{word}' found in html. Re-run likely necessary")
# 			# print(f'url: {url}')
# 			# print(f"file: {out_file}")
# 			# # res = input("rerun? (y)es or (n)o")
# 			# # # print(res)
# 			# # if res[0].lower() == 'y':
# 			# print("Rerunning...")
# 			# html_text = java_scrape_url(url)

# 			# with open(out_file, 'w') as outf:
# 			# 	outf.write(html_text)
# 	# if Path(out_file).name == 'PMID36944891.doi.scrape.html':
# 	# 	sys.exit()


# 	identifiers = get_identifier(html_text)

# 	return(identifiers)



def parse_pmc_efetch_xml(file_name):

	# key_terms = ["PRJNA\d+", "PRJEB\d+", "SRA\d+", "ERA\d+", "SRR\d+", "ERR\d+", "GSE\d+", "GSM\d+", "SAMN\d+", "SAMEA\d+", "SRX\d+", "ERX\d+"]

	if not isfile(file_name):
		sys.exit(f"pmc file not found: {file_name}")

	if os.path.getsize(file_name) > 50000000:
		sys.exit("pmc file is much too large to be believed...")

	# try_get_fields = ["Title", 'PubDate', 'Source']

	out_dict = {}

	f = open(file_name, 'r')
	# print("  {}".format(file_name))

	soup = BeautifulSoup(f, 'xml')


	# print(soup.prettify())
	if "pmc-articleset" not in soup.prettify():
		return([])

	for doc in soup.find_all("pmc-articleset"):

		raw_xml = doc.get_text()

		identifiers = get_identifier(raw_xml)

		abstract = try_get_text(doc, 'abstract')
		abstract = abstract.replace("\n", " ")
		abstract = abstract.replace("\t", " ")
		abstract = abstract.replace("\r", " ")
		# print(abstract)
		# print(doc.prettify())
		# sys.exit()

	identifiers = [i.strip() for i in identifiers]

	return(identifiers)


def elink_to_bpj(identifier, force = False):

	if identifier.startswith(('SRA','ERA','SRP','ERP', 'SRX','ERX','SRR','ERR')):
		db = 'sra'
	elif identifier.startswith(('SAMN','SAMEA')):
		db = 'biosample'
	elif identifier.startswith(("GSE",'GSM')):
		db = 'gds'

	out_file =  f"./xmls/{identifier}.elink.xml"


	if not isfile(out_file) or force:

		call = f"esearch -db {db} -query '{identifier}' | elink -target bioproject | esummary > temp.xml"
		print("  🔗 ", call)

		p = Popen(call, shell=True, stdout=PIPE, stderr=PIPE)
		p.communicate()
		os.rename("temp.xml", out_file)


	with open(out_file,'r') as f:
		soup = BeautifulSoup(f, 'xml')
		bioprojects = get_identifier(soup.prettify(), bioproject_only=True)

	# print("id:", identifier)
	# print("db:", db)
	# print("xml:", out_file)
	# print("result:", bioprojects)
	# input()


	return(bioprojects)

def parse_pubmed_esummary_xml(file_name, single=False):


	if not isfile(file_name):
		return(False)

	if os.path.getsize(file_name) > 50000000:
		return(False)

	try_get_fields = ["Title", 'PubDate', 'Source', "FullJournalName"]

	out_dict = {}


	f = open(file_name, 'r')
	print("  {}".format(file_name))

	soup = BeautifulSoup(f, 'xml')


	# print(len(soup.find_all("DocumentSummarySet")), "DocumentSummarySet", sep='\t')
	# print(len(soup.find_all("DocumentSummary")), 'DocumentSummary', sep='\t')
	# print()


	# total_docs = len(soup.find_all("DocumentSummary"))

	docs = soup.find_all("DocumentSummary")

	if not docs:
		return None
	for doc_i, doc in enumerate(docs):
		doc_dict = {}

		for field in try_get_fields:
			doc_dict[field] = try_get_text(doc, field)


		Attributes = doc.find_all("ArticleId")

		ids = ['pubmed', 'pmc', 'doi', 'pii']

		for Attribute in Attributes:

			if Attribute.find('IdType').get_text() in ids:

				name = Attribute.find('IdType').get_text()
				val  = Attribute.find('Value').get_text()

				doc_dict[name] = val

		for i in ids:
			try:
				doc_dict[i]
			except KeyError:
				doc_dict[i] = None



		out_dict[doc_dict['pubmed']] = doc_dict

	if single:
		return(doc_dict)

	return(out_dict)


class Logger(object):
	def __init__(self, file_name):
		self.terminal = sys.stdout
		self.file_name = file_name
		self.log = open(file_name, "w")

	def clear_ansi(self, message):
		return(message.replace("\033[1m", "").replace("\033[0m",""))

	def write(self, message):
		self.terminal.write(message)
		self.log.write(self.clear_ansi(message))

	def flush(self):
		self.terminal.flush()
		self.log.flush()



## Parsing functions for xmls
def parse_gds_esummary_xml(bpj):

	file_name = f"xmls/{bpj}.gsm.esummary.xml"

	if not isfile(file_name):
		return(False, False, False)

	gsm_to_srx = {}
	srx_to_gsm = {}
	gse_to_pmid = {}

	out_dict = {}

	sub_file_count = 0
	lines=[]

	with open(file_name, 'r') as f:
		# print("  {}".format(file_name))
		for line in f:
			# print(line)
			lines.append(line.strip())
			if "</DocumentSummarySet>" in line:
				with open("temp.xml", 'w') as tempf:
					tempf.write("\n".join(lines))
					lines = []
				# sys.exit()

				sub_file_count += 1

				# print("  SF{}".format(sub_file_count))
				with open("temp.xml", 'r') as tempf:
					soup = BeautifulSoup(tempf, 'xml')

				for doc in soup.find_all("DocumentSummary"):
					# print(doc.prettify())


					entry_type = try_get_text(doc, "entryType")

					if entry_type == "GSE":

						
						doc_dict = {}
						doc_dict["GSE_id"] = doc.find("Accession").get_text()
						doc_dict["GSE_title"] = doc.find("title").get_text()
						doc_dict["GSE_summary"] = doc.find("summary").get_text()
						doc_dict["GPL_id"] = try_get_text(doc, "GPL")
						if doc_dict["GPL_id"] != "":
							doc_dict["GPL_id"] = "GPL" + doc_dict["GPL_id"]
						doc_dict["taxon"] = doc.find("taxon").get_text()
						doc_dict["gdsType"] = doc.find("gdsType").get_text()
						doc_dict["date"] = doc.find("PDAT").get_text()
						doc_dict["n_samples"] = doc.find("n_samples").get_text()
						doc_dict["SRP_id"] = try_get_text(doc, "TargetObject")
						doc_dict["BioProject"]  = try_get_text(doc, "BioProject")

						PubMedId = doc.find("PubMedIds")
						if PubMedId:
							PubMedId = PubMedId.get_text().strip()
						else:
							PubMedId = "-"


						if PubMedId == "" or len(PubMedId) < 4:
							PubMedId = "-"

						doc_dict["PMID"]  = PubMedId.split()[0]




						for sample in doc.find_all("Sample"):
							acc = sample.find("Accession").get_text()
							tit = sample.find("Title").get_text()
							doc_dict["GSM_title"] = tit

							try:
								out_dict[acc]
							except KeyError:
								out_dict[acc] = deepcopy(doc_dict)


					elif "GSM" in try_get_text(doc, "Accession"):
						GSM_id = try_get_text(doc, "Accession")
						SRX_id = try_get_text(doc, "TargetObject")
						out_dict[GSM_id]['SRX_id'] = SRX_id


						if SRX_id :
							gsm_to_srx[GSM_id] = SRX_id
							srx_to_gsm[SRX_id] = GSM_id
							if "SRX" not in SRX_id:
								print(doc.prettify())
								print("ERROR: SRX_id not what expected:", SRX_id)
								sys.exit()





	out_fields = ["GSE_id",
		"SRP_id",
		"BioProject",
		"GSM_title",
		"gdsType",
		"GSE_summary",
		"GSE_title",
		"GPL_id",
		"taxon",
		"GSE_date",
		"GSE_n_samples"]




	# sys.exit()


	return(out_dict, gsm_to_srx, srx_to_gsm)



	# with open(out_file, 'w') as f:
	# 	print("\t".join(["GSM_id"] + out_fields), file=f)

	# print("{} entries processed".format(len(out_dict.keys())))
	# # print(out_dict.keys())

	# for key in out_dict.keys():
	# 	# bpjs.add(out_dict[key]["BioProject"])
	# 	to_print = [key]
	# 	for field in out_fields:
	# 		to_print.append(out_dict[key][field])
	# 	with open(out_file, 'a') as f:
	# 		print("\t".join(map(str, to_print)), file=f)
	# # return(bpjs)

def parse_sra_esummary_xml(file_name):



	if not isfile(file_name):
		return(False)

	if os.path.getsize(file_name) > 50000000:
		return(False)


	fields = [
	"SRA_id",
	"SRP_id",
	"SRX_id",
	"GSM_id",
	"BioProject",
	"BioSample",
	# "Title",
	"Experiment_name",
	"Study_name",
	"CreateDate",
	"UpdateDate",
	"LIBRARY_STRATEGY",
	"LIBRARY_SOURCE",
	"LIBRARY_SELECTION",
	"LIBRARY_CONSTRUCTION_PROTOCOL",
	"Platform",
	"total_bases",
	"total_runs",
	"total_size",
	"total_spots",
	"ScientificName",
	"taxid",
	"center_name",
	"contact_name",
	"lab_name",
	"runs",
	"run_list",
	"run_count",]

	out_dict = {}
	sub_file_count = 0
	lines=[]
	with open(file_name, 'r') as f:
		print("  {}".format(file_name))
		for line in f:
			# print(line)
			lines.append(line.strip())
			if "</DocumentSummarySet>" in line:
				with open("temp.xml", 'w') as tempf:
					tempf.write("\n".join(lines))
					lines = []
				# sys.exit()

				sub_file_count += 1

				# print("  SF{}".format(sub_file_count))
				with open("temp.xml", 'r') as tempf:
					soup = BeautifulSoup(tempf, 'xml')


				for doc in soup.find_all("DocumentSummary"):

					status = try_get_accession(doc, "Experiment", "status")

					# print(soup.prettify())

					# for line in soup.prettify().split("\n"):
					# 	print(line)
					# 	if "LinkSetDb" in line:
					# 		sys.exit

					# sys.exit()

					# print("\n\n")
					doc_dict = {}
					# doc_dict["Id"] = try_get_text(doc, "Id")
					# doc_dict["Title"] = try_get_text(doc, "Title")
					doc_dict["LIBRARY_STRATEGY"] = try_get_text(doc, "LIBRARY_STRATEGY")
					doc_dict["LIBRARY_SOURCE"] = try_get_text(doc, "LIBRARY_SOURCE")
					doc_dict["LIBRARY_SELECTION"] = try_get_text(doc, "LIBRARY_SELECTION")
					doc_dict["LIBRARY_CONSTRUCTION_PROTOCOL"] = try_get_text(doc, "LIBRARY_CONSTRUCTION_PROTOCOL")
					doc_dict["LIBRARY_NAME"] = try_get_text(doc,"LIBRARY_NAME")
					doc_dict["BioProject"] = try_get_text(doc, "Bioproject")
					doc_dict["BioSample"] = try_get_text(doc, "Biosample")
					doc_dict["CreateDate"] = try_get_text(doc, "CreateDate")
					doc_dict["UpdateDate"] = try_get_text(doc, "UpdateDate")


					SRX_id = try_get_accession(doc, "Experiment", "acc")
					doc_dict["SRX_id"] = SRX_id


					doc_dict["Experiment_name"] = try_get_accession(doc, "Experiment", "name")
					
					if "GSM" == doc_dict["Experiment_name"][:3]:
						doc_dict["GSM_id"] = doc_dict["Experiment_name"].split()[0].strip(":")
					else:
						doc_dict["GSM_id"] = ''

					# if try_get_text(doc, "Biosample") == "":
					# 	print(doc.prettify())
					# 	print("SRA srp not found")
					# 	sys.exit()


					doc_dict["Platform"] = try_get_accession(doc, "Platform", "instrument_model")
					doc_dict["total_bases"] = try_get_accession(doc, "Statistics", "total_bases")
					doc_dict["total_runs"] = try_get_accession(doc, "Statistics", "total_runs")
					doc_dict["total_size"] = try_get_accession(doc, "Statistics", "total_size")
					doc_dict["total_spots"] = try_get_accession(doc, "Statistics", "total_spots")
					doc_dict["SRA_id"] = try_get_accession(doc, "Submitter", "acc")
					doc_dict["center_name"] = try_get_accession(doc, "Submitter", "center_name")
					doc_dict["contact_name"] = try_get_accession(doc, "Submitter", "contact_name")
					doc_dict["lab_name"] = try_get_accession(doc, "Submitter", "lab_name")
					doc_dict["SRP_id"] = try_get_accession(doc, "Study", "acc")
					doc_dict["Study_name"] = try_get_accession(doc, "Study", "name")
					doc_dict["ScientificName"] = try_get_accession(doc, "Organism", "ScientificName")
					doc_dict["taxid"] = try_get_accession(doc, "Organism", "taxid")


					run_dict = {}
					for run in doc.find_all("Run"):
						acc = run.attrs["acc"]
						tot_b = run.attrs["total_bases"]
						tot_s = run.attrs["total_spots"]

						run_dict[acc] = [tot_b, tot_s]

					doc_dict["runs"] = run_dict
					doc_dict["run_list"] = ",".join(list(run_dict.keys()))

					doc_dict["run_count"] = len(run_dict.keys())

					# pprint(doc_dict)

					if status == "public":
						try:
							out_dict[SRX_id]
						except KeyError:
							out_dict[SRX_id] = doc_dict

					# print(doc.prettify())
					# sys.exit()


		# sys.exit()
	return(out_dict)#, fields)

def parse_BioSample_esummary_xml(file_name):


	if not isfile(file_name):
		return(False)


	if os.path.getsize(file_name) > 50000000:
		return(False)


	try_get_fields = ["Title", "Accession", "Date", "Organization", "Taxonomy", "Organism", "Paragraph"]
	Attribute_fields = ["sample_name", "age", "biomaterial_provider", "collected_by", "collection_date", "dev_stage", "ecotype", "genotype", "phenotype", "replicate", "sample_type", "tissue_type", "source_name", "time", 'treatment']


	out_dict = {}
	lines=[]
	sub_file_count = 0
	with open(file_name, 'r') as f:
		print("  {}".format(file_name))
		for line in f:
			# print(line)
			lines.append(line.strip())
			if "</DocumentSummarySet>" in line:
				with open("temp.xml", 'w') as tempf:
					tempf.write("\n".join(lines))
					lines = []
				# sys.exit()

				sub_file_count += 1

				# print("  SF{}".format(sub_file_count))
				with open("temp.xml", 'r') as tempf:
					soup = BeautifulSoup(tempf, 'xml')

				for doc in soup.find_all("DocumentSummary"):
					doc_dict = {}

					Accession = try_get_text(doc, "Accession")

					if Accession == '':
						print("ERROR: could not find accession for the following xml entry\n".format(doc.prettify()))
						sys.exit()

					for field in try_get_fields:
						doc_dict[field] = try_get_text(doc, field)



					Attributes = doc.find_all("Attribute")

					for Attribute in Attributes:
						# print(Attribute.prettify())
						attribute_name = Attribute.attrs["attribute_name"]
						if attribute_name in Attribute_fields:
							doc_dict[attribute_name] = Attribute.get_text()
					for field in Attribute_fields:
						try:
							doc_dict[field]
						except KeyError:
							doc_dict[field] = ''


					for Id in doc.find_all("Id"):
						try:
							attr = Id.attrs["db_label"]
						except KeyError:
							attr = False

						if attr is not False:
							if attr == "Sample name":
								# print(attr)						
								doc_dict["sample_name"] = Id.get_text()

					# if Accession == "SAMN10924151":
					# 	# print(doc.prettify())
					# 	pprint(doc_dict)
					# 	print(doc_dict["sample_name"])
					# 	print(doc_dict["treatment"])
					# 	sys.exit()
					# pprint(doc_dict)
					out_dict[Accession] = doc_dict
					# sys.exit()


	return(out_dict)

# def parse_pubmed_esummary_xml(bpj):
# 	file_name = f"xmls/{bpj}.pubmed.esummary.xml"

# 	if not isfile(file_name):
# 		return(False)

# 	if os.path.getsize(file_name) > 50000000:
# 		return(False)

# 	try_get_fields = ["Title", 'PubDate', 'Source']#, "Accession", "Date", "Organization", "Taxonomy", "Organism", "Paragraph"]
# 	# Attribute_fields = ["sample_name", "age", "biomaterial_provider", "collected_by", "collection_date", "dev_stage", "ecotype", "genotype", "phenotype", "replicate", "sample_type", "tissue_type", "source_name", "time", 'treatment']


# 	out_dict = {}
# 	lines=[]
# 	sub_file_count = 0
# 	with open(file_name, 'r') as f:
# 		print("  {}".format(file_name))
# 		for line in f:
# 			line = line.rstrip()
# 			# print(line)
# 			lines.append(line.strip())
# 			if "</DocumentSummarySet>" in line:
# 				with open("temp.xml", 'w') as tempf:
# 					tempf.write("\n".join(lines))
# 					lines = []
# 				# sys.exit()

# 				sub_file_count += 1

# 				# print("  SF{}".format(sub_file_count))
# 				with open("temp.xml", 'r') as tempf:
# 					soup = BeautifulSoup(tempf, 'xml')

# 				for doc in soup.find_all("DocumentSummary"):
# 					doc_dict = {}


# 					for field in try_get_fields:
# 						doc_dict[field] = try_get_text(doc, field)


# 					# print(doc_dict)
# 					Attributes = doc.find_all("ArticleId")

# 					ids = ['pubmed', 'pmc', 'doi']

# 					for Attribute in Attributes:
# 						# print()
# 						# print(Attribute.prettify())
# 						# print()
# 						# print(Attribute.find('IdType').get_text())
# 						if Attribute.find('IdType').get_text() in ids:

# 							name = Attribute.find('IdType').get_text()
# 							val  = Attribute.find('Value').get_text()

# 							doc_dict[name] = val


# 					# 	attribute_name = Attribute.attrs["attribute_name"]
# 					# 	if attribute_name in Attribute_fields:
# 					# 		doc_dict[attribute_name] = Attribute.get_text()
# 					# for field in Attribute_fields:
# 					# 	try:
# 					# 		doc_dict[field]
# 					# 	except KeyError:
# 					# 		doc_dict[field] = ''


# 					# for Id in doc.find_all("Id"):
# 					# 	try:
# 					# 		attr = Id.attrs["db_label"]
# 					# 	except KeyError:
# 					# 		attr = False

# 					# 	if attr is not False:
# 					# 		if attr == "Sample name":
# 					# 			# print(attr)						
# 					# 			doc_dict["sample_name"] = Id.get_text()

# 					# if Accession == "SAMN10924151":
# 					# 	# print(doc.prettify())
# 					# 	pprint(doc_dict)
# 					# 	print(doc_dict["sample_name"])
# 					# 	print(doc_dict["treatment"])
# 					# 	sys.exit()
# 					# pprint(doc_dict)

# 					for i in ids:
# 						try:
# 							doc_dict[i]
# 						except KeyError:
# 							doc_dict[i] = '-'

# 					return(doc_dict)
# 					# sys.exit()


# 	return(out_dict)


def parse_bioproject_esummary_xml(bpj):
	bpj_dict = {}

	file_name = f"xmls/{bpj}.bioproject.esummary.xml"

	with open(file_name, 'r') as f:
		soup = BeautifulSoup(f, 'xml')

	docs = soup.find_all("DocumentSummary")

	if not docs:
		return None

	for doc in docs:
		identifier = doc.find("Project_Acc").get_text()
		# print(try_get_text(doc, "Project_Title"))


		bpj_dict[identifier] = {}

		bpj_dict[identifier]["Project_Title"] = try_get_text(doc, "Project_Title")
		bpj_dict[identifier]["Project_Description"] = try_get_text(doc, "Project_Description")

	return(bpj_dict)



## Parsing functions to lines

def make_bpj_line(bpj_dict, bpj_id):
	line = []
	fields = ['Project_Title', 'Project_Description']

	if not bpj_dict:
		bpj_dict = dict()

	for field in fields:


		try:
			val = bpj_dict[bpj_id][field]
		except KeyError:
			val = '-'
			
		if val == '':
			val = '-'
		line.append(val)
			
	fields = [f"[bioproject] {f}" for f in fields]
	return(line, fields)


def make_bsm_line(bsm_dict, bsm_id):
	line = []


	fields = ['Title', 'Taxonomy', 'Organism', 'source_name', 'sample_name', 'age', 'dev_stage', 'ecotype', 'genotype']

	if not bsm_dict:
		fields = [f"[biosample] {f}" for f in fields]
		return(["-"] * len(fields), fields)
		
	# pprint(bsm_dict[bsm_id])
	# sys.exit()

	for field in fields:
		try:
			val = bsm_dict[bsm_id][field]
		except KeyError:
			val = '-'
			
		if val == '':
			val = '-'
		line.append(val)

	fields = [f"[biosample] {f}" for f in fields]
	return(line, fields)

def make_pmd_line(pmd_dict):

	fields = ['Title', 'Source', 'PubDate', 'doi']

	if not pmd_dict:
		fields = [f"[pubmed] {f}" for f in fields]
		return(["-"] * len(fields), fields)

	line = []

	for field in fields:
		try:
			val = pmd_dict[field]
		except KeyError:
			val = '-'

		line.append(val)

	fields = [f"[pubmed] {f}" for f in fields]
	return(line, fields)

def make_srx_line(sra_dict, srx_id):

	fields = ['Experiment_name', 'LIBRARY_CONSTRUCTION_PROTOCOL', 'LIBRARY_NAME', 'LIBRARY_SELECTION', 'LIBRARY_SOURCE', 'LIBRARY_STRATEGY', 'Platform', 'ScientificName', 'Study_name', 'run_count', 'total_spots', 'CreateDate']
	line=[]

	if not sra_dict:
		fields = [f"[sra] {f}" for f in fields]
		return(["-"] * len(fields), fields)

	for field in fields:
		try:
			val = sra_dict[srx_id][field]
		except KeyError:
			val = '-'

		if val == '':
			val = '-'

		line.append(val)

	line = list(map(str,line))

	fields = [f"[sra] {f}" for f in fields]
	return(line, fields)

def make_gsm_line(gds_dict, gsm_id):
	# fields = ['GPL_id','date', 'GSE_title', 'summary', 'taxon', 'gdsType', 'n_samples', 'SRP_id', 'BioProject', 'PMID', 'GSM_title']
	fields = ['GSM_title', 'GSE_title', 'GSE_summary', 'GPL_id', 'taxon', 'gdsType', 'date' ]
	line=[]




	if not gds_dict:
		fields = [f"[gds] {f}" for f in fields]
		return(["-"] * len(fields), fields)

	if gsm_id == "-":
		fields = [f"[gds] {f}" for f in fields]
		return(["-"] * len(fields), fields)


	# print(gsm_id, "<- gsm_id")
	# pprint(gds_dict[gsm_id])

	for field in fields:
		try:
			val = gds_dict[gsm_id][field]
		except KeyError:
			val = '-'

		if val == '':
			val = '-'

		line.append(val)

	line = list(map(str,line))

	fields = [f"[gds] {f}" for f in fields]
	return(line, fields)

# def get_identifier(d, keys):
# 	all_hits = []
# 	for key in keys:
# 		hits = re.findall(f"{key}\d+", d)
# 		all_hits += hits

# 	return(list(set(all_hits)))

#### Running all the bioprojects


