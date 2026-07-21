
import sys
from pprint import pprint
from pathlib import Path
from subprocess import Popen, PIPE




project_file = "../+tables/projects.filtered.txt"
# project_file = "../+tables/loci.filtered.txt"

abbv_d = dict()

with open(project_file, 'r') as f:


	header = f.readline().strip().split('\t')
	# for i,h in enumerate(header):
	# 	print(i,h)

	for line in f.readlines():

		line = line.strip().split('\t')

		if line[header.index("f_pass")] ==  'TRUE':

			# print(line)
			project = line[header.index('project')]
			abbv    = line[header.index('abbv')]

			try:
				abbv_d[abbv].append(project)

			except KeyError:
				abbv_d[abbv] = [project]



pprint(abbv_d)

for abbv in abbv_d.keys():
	print(abbv)

	projects = abbv_d[abbv]

	temp_combined    = Path('temp_combined.gff3')
	temp_sorted      = Path('temp_sorted.gff3')
	temp_clustered   = Path('temp_clustered.gff3')
	temp_reclustered = Path('temp_reclustered.gff3')
	temp_meta        = Path('temp_meta.gff3')


	gff_header = ''

	with open(temp_combined, 'w') as outf:
		for i,project in enumerate(projects):
			with open(Path("../+annotations", project, 'tradeoff/loci.gff3'), 'r') as f:


				for line in f:
					if i == 0 and line.startswith("#"):
						gff_header += line
					line = line.replace("sizecall=", f"project={project};sizecall=")
					print(line.strip(), file=outf)



	# print(" ".join(['bedtools','sort','-i', str(temp_combined)]))
	with open(temp_sorted, 'w') as outf:
		p = Popen(['bedtools','sort','-i', str(temp_combined)], stdout=outf)
		p.wait()


	# print(" ".join(['bedtools','cluster','-i', str(temp_sorted)]))
	with open(temp_clustered, 'w') as outf:
		p = Popen(['bedtools','cluster','-i', str(temp_sorted)], stdout=outf)
		p.wait()




	clusters = []
	with open(temp_clustered, 'r') as f:
		for line in f:
			line = line.strip().split()

			cluster_id = int(line[9])
			feature    = line[2]
			locus      = f'{line[0]}:{line[3]}-{line[4]}'

			if feature == 'otherRNA':
				sizes = set()
			else:
				sizes = set([int(k) for k in feature.split("_")[1:]])

			attrs      = line[8].split(';')
			name       = attrs[0].split('=')[1]
			project    = attrs[1].split('=')[1]
			depth      = int(attrs[3].split('=')[1])

			if len(sizes) == 2 and depth < 250:
				sizes = set()
			elif len(sizes) == 3 and depth < 500:
				sizes = set()


		
			member = (name, project, feature, sizes, locus, depth, line)

			if cluster_id > len(clusters):
				clusters.append([member])
			else:
				clusters[cluster_id-1].append(member)


	parent_d = dict()


	with open(temp_meta, 'w') as outf:
		print(gff_header, file=outf)

		extra_clusters = 1

		for cluster_i, cluster in enumerate(clusters):

			if len(cluster) == 1:

				key = (cluster[0][0], cluster[0][1])
				parent_d[key] =  f"metalocus-{cluster_i + 1}"
				matches = [set([0,0])]

			else:

				matches = []
				for bi, b in enumerate(cluster):
					# print(b)
					for ai, a in enumerate(cluster):

						if a == b:
							continue

						if bool(a[3] & b[3]):
							match = True

						elif not a[3] and not b[3]:
							match = True

						# elif length(a[3]) == 3 and not b[3]:
						# 	match = True

						# elif length(b[3]) == 3 and not a[3]:
						# 	match = True

						else:
							match = False


						if match:
							match = sorted([ai, bi])

							if match not in matches:

								matches.append(match)
						else:
							matches.append([ai, ai])

			# print(matches)

			def cluster_matches(matches):

				matches = [set(m) for m in matches]

				i = 0
				while True:

					if i == 0:
						start_length = len(matches)

					# print(i, matches)


					merges = []

					for j in range(len(matches)-1, i, -1):
						# print(j, len(matches))

						if bool(matches[i] & matches[j]):
							# print(f'  merging {j} {matches[j]} into {i} {matches[i]}')
							matches[i] = matches[i].union(matches[j])
							del matches[j]



					i += 1

					if i >= len(matches):
						if len(matches) == start_length:
							break

						i = 0

				return(matches)

			clustered_matches = cluster_matches(matches)


			for match_i, match in enumerate(clustered_matches):

				if match_i == 0:
					parent_id = f"metalocus-{cluster_i + 1}"
				else:
					parent_id = f"metalocus-{len(clusters) + extra_clusters}"
					extra_clusters += 1

				deepest_member = None # snicker
				deepest_depth  = 0

				lefts  = []
				rights = []


				for member_i in match:
					member = cluster[member_i]

					depth = member[5]

					if depth > deepest_depth:
						deepest_member = member
						deepest_depth = depth


					member_left  = int(member[6][3])
					member_right = int(member[6][4])

					lefts.append(member_left)
					rights.append(member_right)



					key = (member[0], member[1])
					parent_d[key] = parent_id


				del deepest_member[6][9]

				out_line = deepest_member[6]

				attrs = out_line[8].split(';')
				attrs = attrs[2:]

				out_line[3] = str(min(lefts))
				out_line[4] = str(max(rights))



				attrs = [
					f"ID={parent_id}",
					f"member_loci={len(match)}",
					f"rep_locus={deepest_member[0]}-{deepest_member[1]}",
					f"meta_defined_locus={len(match) > 1}"
					] + attrs

				out_line[8] =  ";".join(attrs)

				print("\t".join(out_line), file=outf)







		
	with open(temp_reclustered, 'w') as outf:
		print(gff_header, file=outf)
		with open(temp_clustered, 'r') as f:
			for line in f:
				line = line.strip().split("\t")

				cluster_id = int(line[9])
				feature    = line[2]
				locus      = f'{line[0]}:{line[3]}-{line[4]}'

				if feature == 'otherRNA':
					sizes = set()
				else:
					sizes = set([int(k) for k in feature.split("_")[1:]])

				attrs      = line[8].split(';')
				name       = attrs[0].split('=')[1]
				project    = attrs[1].split('=')[1]
				depth      = int(attrs[3].split('=')[1])


				parent_id = parent_d[(name, project)]

				attrs.insert(1,f"metalocus={parent_id}")

				line = line[:8] + [";".join(attrs)]


				print("\t".join(line), file=outf)

		# print(clustered_matches)
		# print()

		# input()

		# pprint(cluster_d)
		# input()


	temp_reclustered.rename(f"{abbv}.gff3")
	temp_meta.rename(f"{abbv}.meta.gff3")


	temp_combined.unlink()
	temp_sorted.unlink()
	temp_clustered.unlink()

# pprint(abbv_d)


