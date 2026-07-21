import sys
from pprint import pprint
import json
from subprocess import Popen, PIPE, DEVNULL
from pathlib import Path
# from openpyxl import load_workbook
from python_calamine import CalamineWorkbook



genome_file = Path("../get_genomes/01out-selected_genomes.xlsx")


print("loading genome list...")
workbook = CalamineWorkbook.from_path(genome_file)
sheets = workbook.sheet_names
df = workbook.get_sheet_by_name(sheets[0]).to_python()

header = df.pop(0)
# print(header)

df = [d for d in df if d[header.index('selected')] == 'x']


out_file = "01out-taxonomy_info.txt"
with open(out_file, 'w') as outf:
	print("abbv","nmemonic", "species",'genus_tax_id','taxid','phylum','class','order','family','genus', sep='\t', file=outf)



json_dir = Path("01out-json")
json_dir.mkdir(parents=True, exist_ok=True)

def get_json_data(file):

	with open(file, 'r') as f:
		try:
			data = json.load(f)
		except json.decoder.JSONDecodeError:
			return

	return(data)

def get_species_taxid(species):
	if len(species.split()) > 2:
		species = " ".join(species.split()[:2])


	call = ['datasets', 'summary', 'taxonomy', 'taxon', species]

	json_file = Path(json_dir, species.replace(" ", "_")).with_suffix(".json")

	if json_file.is_file():
		data = get_json_data(json_file)

		if data:
			taxid  = data['reports'][0]['taxonomy']['tax_id']
			return(taxid)

	with open(json_file, 'w') as outf:
		p = Popen(call, stdout=outf, stderr=PIPE, encoding='utf-8')
		err = [l.strip() for l in p.stderr]
		p.wait()

	data = get_json_data(json_file)

	if data:
		taxid  = data['reports'][0]['taxonomy']['tax_id']
		return(taxid)



def get_nmemonics():
	d = {}
	with open("uniprot_nmemonics.txt", 'r') as f:

		for line in f:
			line = line.strip()
			if len(line) == 0:
				continue

			nmemonic = line.split()[0]
			if len(nmemonic) == 5:

				d[nmemonic] = line.split("=")[-1]
	return(d)

nmemonic_d = get_nmemonics()

rev_d = {}

rev_d['Aspergillus fumigatus']           = 'ASPFM'
rev_d['Candida albicans']                = 'CANAX'
rev_d['Athelia rolfsii']                 = '9AGAM'
rev_d['Clonostachys rosea']              = 'BIOOC'
rev_d['Colletotrichum higginsianum']     = '9PEZI'
rev_d['Colletotrichum sublineolum']      = '9PEZI'
rev_d['Ceratobasidium']                  = '-'
rev_d['Epicoccum nigrum']                = 'EPING'
rev_d['Marssonina brunnea']              = '9HELO'
rev_d['Malassezia sympodialis']          = 'MALSM'
rev_d['Metarhizium acridum']             = '9HELO'
rev_d['Neurospora crassa']               = 'NEUCS'
rev_d['Paraglomus occultum']             = '9GLOM'
rev_d['Rhodotorula sp. JG-1b']           = '9BASI'
rev_d['Rhizoctonia solani']              = '9AGAM'
rev_d['Sanghuangporus vaninii']          = '9AGAM'
rev_d['Schizosaccharomyces japonicus']   = 'SCHJP'
rev_d['Sporisorium scitamineum']         = '9BASI'
rev_d['Trichoderma asperellum']          = '9HYPO'
rev_d['Trichoderma atroviride']          = 'HYPAT'
rev_d['Trichoderma reesei']              = 'HYPJE'
rev_d['Vanderwaltozyma polyspora']       = '9SACH'
rev_d['Verticillium albo-atrum']         = '9PEZI'
rev_d['Verticillium nonalfalfae']        = '9PEZI'
rev_d['Yarrowia lipolytica']             = 'YARLL'
rev_d['Volvariella volvacea']            = '9AGAR'
rev_d['Schizosaccharomyces pombe']       = 'SCHPM'
rev_d['Botrytis cinerea']                = 'BOTFU'
rev_d['Botryosphaeria dothidea']         = '9PEZI'
rev_d['Curvularia lunata']               = 'COCLU'
rev_d['Didymella segeticola']            = '9PLEO'
rev_d['Fusarium brachygibbosum']         = '9HYPO'
rev_d['Fusarium graminearum']            = 'GIBZA'
rev_d['Ganoderma sinense']               = '9APHY'
rev_d['Histoplasma capsulatum']          = 'AJECA'
rev_d['Isaria fumosorosea']              = '9HYPO'
rev_d['Lasiodiplodia theobromae']        = '9PEZI'
rev_d['Mucor lusitanicus']               = 'MUCCL'
rev_d['Nosema ceranae']                  = '9MICR'
rev_d['Ophiocordyceps sinensis']         = '9HYPO'
rev_d['Pichia fermentans']               = '9ASCO'
rev_d['Pleurotus tuoliensis']            = '9AGAR'
rev_d['Puccinia striiformis']            = '9BASI'
rev_d['Puccinia triticina']              = '9BASI'
rev_d['Saccharomyces cerevisiae']        = 'YEASX'
rev_d['Ustilago maydis']                 = 'MYCMD'
rev_d['Valsa mali']                      = '9PEZI'
rev_d['Ascosphaera apis']                = '9EURO'

rev_d['Ascochyta rabiei']                = 'DIDRA'
rev_d['Botrytis elliptica']              = '9HELO'
rev_d['Ceratobasidium']                  = '9AGAM'



for row in df:
	species = row[header.index("organism")]
	abbv    = row[header.index("abbv")]
	genus   = species.split()[0]


	try:
		nmemonic = genus[:3] + species.split()[1][:2]
		nmemonic = nmemonic.upper()
	except IndexError:
		nmemonic = genus[:5].upper()

	if species in rev_d:
		nmemonic = rev_d[species]

	elif nmemonic not in nmemonic_d:
		nmemonic = '-'

	else:
		if nmemonic_d[nmemonic] != species:
			nmemonic += "*"


	json_file = Path(json_dir, genus.replace(" ", "_")).with_suffix(".json")

	if json_file.is_file():
		data = get_json_data(json_file)


	if not json_file.is_file() or not data:

		taxon = genus

		if genus == 'Cryptococcus':
			taxon = '5206'

		elif genus == 'Rhizophagus':
			taxon = '1129544'

		call = ['datasets', 'summary', 'taxonomy', 'taxon', taxon]

		with open(json_file, 'w') as outf:
			p = Popen(call, stdout=outf, stderr=PIPE, encoding='utf-8')
			err = [l.strip() for l in p.stderr]
			p.wait()

		data = get_json_data(json_file)

	# try:
	# 	data = json.loads(out)
	# except json.decoder.JSONDecodeError:
	# 	print(species, "<- error")
	# 	continue
		# sys.exit()

	species_taxid = get_species_taxid(species)

	if not species_taxid:
		print(f"{abbv} species search failed...")

	if not data:
		print(f"{abbv} genus search failed...")
		print(f'   call: {" ".join(call)}')
		print(f'   err:')
		pprint(err)
		print("   skipping...")
		continue


	taxid  = data['reports'][0]['taxonomy']['tax_id']
	phylum = data['reports'][0]['taxonomy']['classification']['phylum']['name']

	try:
		classs = data['reports'][0]['taxonomy']['classification']['class']['name']
	except KeyError:
		classs = "NONE"

	try:
		orderr = data['reports'][0]['taxonomy']['classification']['order']['name']
	except KeyError:
		orderr = "NONE"
	try:
		family = data['reports'][0]['taxonomy']['classification']['family']['name']
	except KeyError:
		family = "NONE"

	try:
		genus  = data['reports'][0]['taxonomy']['classification']['genus']['name']
	except KeyError:
		genus = "NONE"




	# print(phylum)

	with open(out_file, 'a') as outf:
		print(abbv, nmemonic, species, taxid, species_taxid, phylum, classs, orderr, family, genus, sep='\t', file=outf)
		print(abbv, nmemonic, taxid, species_taxid, phylum, species, sep='\t')

	# sys.exit()

# with open('/path/to/file.jsonl') as f:
#     data = [json.loads(line) for line in f]
