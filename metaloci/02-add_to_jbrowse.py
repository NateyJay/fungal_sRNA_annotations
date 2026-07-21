
import sys
from pathlib import Path

genomes = {}

for genome in Path("../+genomes/").glob("*.fa"):
	print(genome)

	genomes[genome.name[:5]] = genome



with open("02out-jbrowse_commands.sh", 'w') as outf:

	for ann_file in Path("01out-meta_gffs").glob("*.gff3"):

		genome = genomes[ann_file.name[:5]]

		# print()
		# print(genome)
		# print(genome.name)
		if "all" in str(ann_file):
			display_mode = 'compact'
		else:
			display_mode = 'normal'

		jbrowse_command = f'jbrowse add-track {ann_file} --category metaloci --target /Volumes/Web --subDir metaloci --load copy -a {genome.stem} --force --config \'{{"displays":[{{"type":"LinearBasicDisplay","displayId":"{ann_file.stem}","renderer":{{"type":"SvgFeatureRenderer","color1":"jexl:customColor(feature)","displayMode": "{display_mode}"}}}}]}}\''

		print(jbrowse_command, file=outf)
