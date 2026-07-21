
import sys


with open("Bocin.meta.gff3", 'r') as f:

	for line in f:

		if line.startswith("#"):
			continue

		line = line.strip().split()

		attrs = line[8]
		attrs = attrs.split(";")

		name = attrs[0]
		rna  = attrs[-1]

		name = name.lstrip("ID=")
		rna  = rna.lstrip("majorRNA=")

		# print(attrs)
		print(">" + name)
		print(rna)
