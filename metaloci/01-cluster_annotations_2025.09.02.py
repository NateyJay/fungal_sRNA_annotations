
import sys
from pprint import pprint
from pathlib import Path
from subprocess import Popen, PIPE
from statistics import median


class memberClass():
	def __init__(self, line):
		'''stores a gff line with more detail'''


		cluster_id = int(line[9])
		feature    = line[2]
		locus      = f'{line[0]}:{line[3]}-{line[4]}'

		line = line[:9]

		if feature == 'OtherRNA':
			sizes = set()
		else:
			sizes = set([int(k) for k in feature.split("_")[1:]])


		attrs = dict(item.split("=") for item in line[8].split(";"))
		name       = attrs['ID']
		project    = attrs['project']
		depth      = int(attrs['depth'])
		rpm        = float(attrs['rpm'])
		cond       = attrs['annotation']

		start = int(line[3])
		stop  = int(line[4])

		## this originally filtered low-depth loci to ignore false precision. I think that this is better to do last.
		# if len(sizes) == 2 and depth < 250:
		# 	sizes = set()
		# elif len(sizes) == 3 and depth < 500:
		# 	sizes = set()

		if len(sizes) == 0:
			line[2] = "OtherRNA"

		elif min(sizes) < 18:
			line[2] = "OtherRNA"
			sizes = set()


		self.cluster_id = cluster_id
		self.feature    = feature
		self.locus      = locus
		self.name       = name
		self.project    = project
		self.cond       = cond
		self.depth      = depth
		self.rpm        = rpm
		self.sizes      = sizes
		self.attrs      = attrs
		self.start      = start
		self.stop       = stop
		self.gff_line   = line

		self.key = (name, project, cond)

		# member = (name, project, feature, sizes, locus, depth, line)
	def __repr__(self):
		return str(self.gff_line)

def get_median_boundaries(loci):

	loci = list(loci)
	loci.sort(key=lambda x: x.rpm, reverse=True)


	i_start = loci[0].start
	i_stop  = loci[0].stop



	def get_avg_overlap(start, stop):
		length = stop - start

		props = []
		for l in loci:

			l_start, l_stop = l.start, l.stop
			l_length = l_stop - l_start
			combined_length = max([stop, l_stop]) - min([start, l_start])



			left  = l_start - start
			right = l_stop - stop

			if right < -1 * length or left > length:
				overlap = 0

			elif left > 0 and right < 0:
				overlap = l_stop - l_start

			elif left > 0 and right >= 0:
				overlap = stop - l_start

			elif left <= 0 and right < 0:
				overlap = l_stop - start

			else:
				overlap = min([length, l_length])


			prop = overlap / combined_length

			# print()
			# print('test_boundaries:', start, '-', stop, length, "nt")
			# print("locus:", l_start, '-', l_stop, l_length, "nt")
			# print(left, 'left error')
			# print(right, 'right error')
			# print('overlap:', overlap)
			# print('length:', length)
			# print('combined_length:', combined_length)
			# print('prop:', prop)

			if prop < 0:
				print("NEGATIVE")
				sys.exit()
			props.append(prop)
		return median(props)

	def try_directions(start, stop, inc):
		out = []
		for ldir in [0, -1, 1]:
			for rdir in [0, -1, 1]:
				score = get_avg_overlap(start + ldir * inc, stop + rdir * inc)
				out.append((score, ldir, rdir))

		out.sort(key= lambda x: x[0], reverse=True)

		return(out[0])


	for resolution in [10, 1]:
		while True:
			score, ldir, rdir = try_directions(i_start, i_stop, inc=resolution)
			if ldir == 0 and ldir == 0:
				break

			i_start += resolution * ldir
			i_stop  += resolution * rdir
			# print(" ", resolution, i_start, i_stop, score, sep='\t')

	return(i_start, i_stop, score)




project_file = "../+tables/projects.filtered.txt"
# project_file = "../+tables/loci.filtered.txt"

abbv_d      = dict()
condition_d = dict()

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
			# print(abbv, project)

			try:
				abbv_d[abbv].append(project)

			except KeyError:
				abbv_d[abbv] = [project]

			conditions = line[header.index('conditions')].split(",")
			condition_d[project] = [c for c in conditions if "." not in c]




# pprint(abbv_d)

for abbv in abbv_d.keys():
# for abbv in ['Bocin']:
	print(abbv)

	projects = abbv_d[abbv]

	temp_combined    = Path('temp_combined.gff3')
	temp_sorted      = Path('temp_sorted.gff3')
	temp_clustered   = Path('temp_clustered.gff3')
	temp_reclustered = Path('temp_reclustered.gff3')
	temp_meta        = Path('temp_meta.gff3')
	temp_final       = Path('temp_reclustered_sorted.gff3')
	temp_final_meta  = Path('temp_reclustered_sorted_meta.gff3')

	## combining all annotations to a single file
	gff_header = ''

	i = 0
	entry_count = 0
	with open(temp_combined, 'w') as outf:
		for project in projects:
			for condition in condition_d[project]:
				print(" ", project, condition)

				input_gff = Path("../+annotations", project, f'tradeoff_{condition}/loci.gff3')

				if not input_gff.is_file():
					print("WARNING: gff file not found. Skipping....")
					continue

				# print(input_gff)
				with open(input_gff, 'r') as f:


					for line in f:
						if i == 0 and line.startswith("#"):
							gff_header += line

						if line.startswith("#"):
							continue

						if "project=" not in line:
							line = line.replace("sizecall=", f"project={project};sizecall=")

						if "annotation=" not in line:
							line = line.replace("sizecall=", f"annotation={condition};sizecall=")

						if "annotation_conditions=" not in line:
							line = line.replace("sizecall=", f"annotation_conditions={condition};sizecall=")
							
						print(line.strip(), file=outf)
						entry_count += 1

				i += 1

	if entry_count == 0:
		print("  Warning: no detected annotations for project}")
		temp_combined.unlink()
		continue

	## sorting 

	# print(" ".join(['bedtools','sort','-i', str(temp_combined)]))
	with open(temp_sorted, 'w') as outf:
		p = Popen(['bedtools','sort','-i', str(temp_combined)], stdout=outf)
		p.wait()


	## clustering by overlaps (reports entries with an extra field)

	# print(" ".join(['bedtools','cluster','-i', str(temp_sorted)]))
	with open(temp_clustered, 'w') as outf:
		p = Popen(['bedtools','cluster','-i', str(temp_sorted)], stdout=outf)
		p.wait()



	## first read of clusters, isolating the entries by cluster

	clusters = []
	with open(temp_clustered, 'r') as f:
		for line in f:
			line = line.strip().split()



			# cluster_id = int(line[9])
			# feature    = line[2]
			# locus      = f'{line[0]}:{line[3]}-{line[4]}'

			# if feature == 'otherRNA':
			# 	sizes = set()
			# else:
			# 	sizes = set([int(k) for k in feature.split("_")[1:]])

			# attrs      = line[8].split(';')
			# name       = attrs[0].split('=')[1]
			# project    = attrs[1].split('=')[1]
			# depth      = int(attrs[4].split('=')[1])

			# if len(sizes) == 2 and depth < 250:
			# 	sizes = set()
			# elif len(sizes) == 3 and depth < 500:
			# 	sizes = set()


		
			# member = (name, project, feature, sizes, locus, depth, line)

			mc = memberClass(line)

			if mc.cluster_id > len(clusters):
				clusters.append([mc])
			else:
				clusters[mc.cluster_id-1].append(mc)


	## assessing clusters, separating those that are not suffiently similar. Regrouping greedily to find if any cluster should be split.

	parent_d = dict()

	with open(temp_meta, 'w') as outf:
		print(gff_header, file=outf)

		extra_clusters = 1

		for cluster_i, cluster in enumerate(clusters):

			if len(cluster) == 1:

				key = cluster[0].key
				parent_d[key] =  f"metalocus-{cluster_i + 1}"
				matches = [set([0,0])]

			else:

				matches = []
				for bi, b in enumerate(cluster):
					# print(b)
					for ai, a in enumerate(cluster):

						if a.key == b.key:
							continue

						if bool(a.sizes & b.sizes):
							match = True

						elif not a.sizes and not b.sizes:
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
					parent_id = f"{abbv}-{cluster_i + 1}"
				else:
					parent_id = f"{abbv}-{len(clusters) + extra_clusters}"
					extra_clusters += 1

				deepest_member = None # snicker
				deepest_depth  = 0

				# lefts  = []
				# rights = []

				loci = list()
				member_projects = set()
				for member_i in match:
					mc = cluster[member_i]

					member_projects.add(mc.project)
					loci.append(mc)


					if mc.depth > deepest_depth:
						deepest_member = mc
						deepest_depth = mc.depth


					# member_left  = int(mc.start)
					# member_right = int(mc.stop)


					# lefts.append(member_left)
					# rights.append(member_right)



					key = mc.key
					parent_d[key] = parent_id
					mc.parent_id  = parent_id




				left, right, score = get_median_boundaries(loci)
				# print(left,right,score)


				# del deepest_member[6][9]

				deepest_member.gff_line[3] = str(left)
				deepest_member.gff_line[4] = str(right)

				# attrs = out_line[8].split(';')
				# attrs = attrs[2:]

				del deepest_member.attrs['ID']
				del deepest_member.attrs['project']


				new_attrs = {
					"ID" : parent_id,
					"member_loci" : len(match),
					"member_projects" : len(member_projects),
					"rep_locus" : f"{deepest_member.name}-{deepest_member.project}-{deepest_member.cond}",
					"meta_defined_locus" : f"{len(match) > 1}"
					}

				deepest_member.attrs = {**new_attrs, **deepest_member.attrs}


				if deepest_depth < 250 and deepest_member.attrs['sizecall'].count("_") >= 1:
					deepest_member.gff_line[2] = "OtherRNA"

				elif deepest_depth < 500 and deepest_member.attrs['sizecall'].count("_") >= 2:
					deepest_member.gff_line[2] = "OtherRNA"



				deepest_member.gff_line[8] = ";".join(f"{k}={v}" for k,v in deepest_member.attrs.items())

				print("\t".join(deepest_member.gff_line), file=outf)







		
	with open(temp_reclustered, 'w') as outf:
		print(gff_header, file=outf)
		with open(temp_clustered, 'r') as f:
			for line in f:
				line = line.strip().split("\t")

				mc = memberClass(line)

				# cluster_id = int(line[9])
				# feature    = line[2]
				# locus      = f'{line[0]}:{line[3]}-{line[4]}'

				# if feature == 'otherRNA':
				# 	sizes = set()
				# else:
				# 	sizes = set([int(k) for k in feature.split("_")[1:]])

				# attrs      = line[8].split(';')
				# name       = attrs[0].split('=')[1]
				# project    = attrs[1].split('=')[1]
				# depth      = int(attrs[4].split('=')[1])


				parent_id = parent_d[mc.key]

				# attrs.insert(1,f"metalocus={parent_id}")


				new_attrs = {
					"ID": f'{mc.name}-{mc.project}-{mc.cond}',
					"metalocus":parent_id
					}

				del mc.attrs['ID']

				mc.attrs = {**new_attrs, **mc.attrs}


				# line = line[:8] + [";".join(attrs)]
				mc.gff_line[8] = ";".join(f"{k}={v}" for k,v in mc.attrs.items())


				print("\t".join(mc.gff_line), file=outf)


	with open(temp_final, 'w') as outf:
		p = Popen(['bedtools','sort','-header','-i', str(temp_reclustered)], stdout=outf)
		p.wait()

	with open(temp_final_meta, 'w') as outf:
		p = Popen(['bedtools','sort','-header','-i', str(temp_meta)], stdout=outf)
		p.wait()

	meta_folder = Path("01out-meta_gffs")
	meta_folder.mkdir(parents = True, exist_ok = True)

	temp_final_meta.rename(Path(meta_folder, f"{abbv}.meta.gff3"))
	temp_final.rename(Path(meta_folder, f"{abbv}.all.gff3"))

	temp_meta.unlink()
	temp_reclustered.unlink()
	temp_combined.unlink()
	temp_sorted.unlink()
	temp_clustered.unlink()


	# print(gff_header)
	# sys.exit()


# pprint(abbv_d)


