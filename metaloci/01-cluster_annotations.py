
import sys
from pprint import pprint
from pathlib import Path
from subprocess import Popen, PIPE
from statistics import median
from collections import deque, Counter

from densestamp import densestamp


ds = densestamp(5)

def get_jaccard_boundaries(loci):

	bounds = set()
	for l in loci:
		bounds.add(l['start'])
		bounds.add(l['stop'])

	bounds = list(bounds)
	bounds.sort()

	windows = []
	for a in bounds:
		for b in bounds:
			window = [a,b, b-a, 0]
			if window not in windows and a < b:
				windows.append(window)


	for w in windows:
		jaccards = []
		for l in loci:
			overlap         = max(0, min(w[1], l['stop']) - max(w[0], l['start']))
			combined_length = max(w[1], l['stop']) - min(w[0], l['start'])
			jaccard         = overlap / combined_length
			jaccards.append(jaccard)

		w[3] = median(jaccards)

	windows.sort(key=lambda x: x[2], reverse=True)
	windows.sort(key=lambda x: x[3], reverse=True)

	return(windows[0][0], windows[0][1], windows[0][3])



	# pprint(windows)
	# sys.exit()




def get_median_boundaries(loci):

	loci = list(loci)
	loci.sort(key=lambda x: x['rpm'], reverse=True)


	i_start = loci[0]['start']
	i_stop  = loci[0]['stop']



	def get_avg_overlap(start, stop):
		length = stop - start

		jaccards = []
		for l in loci:

			l_start, l_stop = l['start'], l['stop']
			l_length        = l_stop - l_start
			combined_length = max([stop, l_stop]) - min([start, l_start])

			## offset for locus coordinates relative to the test window
			left  = l_start - start
			right = l_stop - stop

			if right < -1 * length or left > length:
				overlap = 0

			elif left >= 0 and right <= 0:
				overlap = l_length

			elif left >= 0 and right >= 0:
				overlap = stop - l_start

			elif left <= 0 and right <= 0:
				overlap = l_stop - start

			elif left < 0 and right > 0:
				overlap = length

			else:
				print(l)
				print("window:", start, '-', stop)
				print("locus:", l_start, '-', l_stop)
				sys.exit("can't happen...")
				overlap = min([length, l_length])


			jaccard = overlap / combined_length

			# print()
			# print('test_boundaries:', start, '-', stop, length, "nt")
			# print("locus:", l_start, '-', l_stop, l_length, "nt")
			# print(left, 'left error')
			# print(right, 'right error')
			# print('overlap:', overlap)
			# print('length:', length)
			# print('combined_length:', combined_length)
			# print('prop:', prop)

			if jaccard < 0:
				print("NEGATIVE")
				sys.exit()
			jaccards.append(jaccard)
		return median(jaccards)

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



meta_folder = Path("01out-meta_gffs")
meta_folder.mkdir(parents = True, exist_ok = True)

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





def check_merge(cluster, locus):

	if cluster['start'] > locus['stop']:
		return False

	if cluster['stop'] < locus['start']:
		return False

	if cluster['contig'] != locus['contig']:
		return False

	c = Counter()
	for cl in cluster['loci']:
		sc = cl['sizecall']
		sc = list(sc)
		sc = sorted(sc)
		sc = tuple(sc)
		c[sc] += 1

	mc_sizecall = set(c.most_common()[0][0])

	if mc_sizecall == locus['sizecall']:
		return True

	elif len(mc_sizecall & locus['sizecall']) > 0:
		return True

	elif len(set(range(min(mc_sizecall)-1, max(mc_sizecall)+1)) & locus['sizecall']) ==  len(locus['sizecall']):
		'''also allowing when this locus is size 1 and just outside of range'''
		return True

	return False

def find_orphans(cluster):
	start = cluster['start']
	stop  = cluster['stop']

	orphans = []
	passing = []
	for l in cluster['loci']:
		if l['stop'] < start or l['start'] > stop:
			orphans.append(l)
		else:
			passing.append(l)

	return(passing, orphans)


def bedtools_sort(file):
	temp_file = file.with_suffix('.temp')
	with open(temp_file, 'w') as outf:
		p = Popen(['bedtools','sort','-header','-i', str(file)], stdout=outf)
		p.wait()

	temp_file.rename(file)
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
	gff_contigs = []


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

							if line.startswith("##sequence-region"):
								s = line.split()[1:]
								s[2] = int(s[2])
								gff_contigs.append(s)


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

	gff_contigs.sort(key=lambda x: x[2], reverse=True)

	gff_header = "##gff-version 3"
	for name, start, end in gff_contigs:
		gff_header += f"\n##sequence-region   {name} {start} {end}"

	gff_contigs = [g[0] for g in gff_contigs]


	if entry_count == 0:
		print("  Warning: no detected annotations for project}")
		temp_combined.unlink()
		continue

	## sorting 

	# print(" ".join(['bedtools','sort','-i', str(temp_combined)]))
	with open(temp_sorted, 'w') as outf:
		p = Popen(['bedtools','sort','-i', str(temp_combined)], stdout=outf)
		p.wait()



	initial_clusters = []

	header = ''


	cluster = [None, -1, -1, []]

	with open(temp_sorted, 'r') as f:

		for line in f:
			if line.startswith("#"):
				header += line
				continue

			line = line.strip().split("\t")

			d = { p.split("=")[0] : p.split("=")[1] for p in line[8].split(";")}
			d['contig'] = line[0]
			d['type']   = line[2]
			d['start']  = int(line[3])
			d['stop']   = int(line[4])
			d['strand'] = line[6]

			d['rpm']        = float(d['rpm'])
			d['depth']      = int(d['depth'])
			d['skew']       = float(d['skew'])
			d['complexity'] = float(d['complexity'])
			d['fracTop']    = float(d['fracTop'])
			d['length']     = d['stop'] - d['start']
			d['rpkm']       = d['rpm'] / d['length'] * 1000

			sc = set([int(l) if l.isdigit() else 0 for l in d['sizecall'].split("_")])

			## only sizecalls from 18 - 30 (excludes 17_18)
			if min(sc) <= 18 or max(sc) >= 30:
				sc = set([0])


			## confirming that major RNA is a permitted length
			majorRNAlen = len(d['majorRNA'])
			if majorRNAlen not in sc and sc != {0}:
				sc = {0}


			d['sizecall'] = sc

			if cluster[0] == d['contig'] and cluster[2] >= d['start']:

				cluster[2] = max([d['stop'], cluster[2]])
				cluster[3].append(d)

			else:

				if cluster[0]:
					initial_clusters.append(cluster)

				cluster = [d['contig'], d['start'], d['stop'], [d]]

		initial_clusters.append(cluster)


	clusters = []

	for cluster in initial_clusters:


		out = []
		while len(cluster[3]) > 0:

			for d in cluster[3]:
				merged = False
				for i,o in enumerate(out):

					if check_merge(o, d):
						out[i]['loci'].append(d)
						out[i]['stop'] = max([out[i]['stop'], d['stop']])
						merged = True
						break

				if not merged or not out:

					out.append({})
					# out[-1]['metalocus'] = f"{abbv}-{cluster_i}"
					out[-1]['contig']    = d['contig']
					out[-1]['start']     = d['start']
					out[-1]['stop']      = d['stop']
					out[-1]['sizecall']  = d['sizecall']
					out[-1]['loci']      = [d]



			cluster[3] = []
			for li in range(len(out)):

				# left, right, score = get_median_boundaries(out[li]['loci'])
				left, right, score = get_jaccard_boundaries(out[li]['loci'])
				out[li]['start'] = left
				out[li]['stop']  = right

				out[li]['loci'], orphans = find_orphans(out[li])
				
				cluster[3] += orphans


			tagged = []
			out.sort(key=lambda x: len(x['loci']), reverse=True)

			for i,c in enumerate(out):

				out[i]['primary'] = True
				
				for t_start, t_stop in tagged:
					if c['start'] < t_stop and c['stop'] > t_start:
						out[i]['primary'] = False
						break

				tagged.append([c['start'], c['stop']])



			clusters += out
			out = []

	print()
	print("  ->", len(clusters), 'clusters found')
	print()

	temp_all_file  = Path("temp.all.gff3")
	temp_meta_file = Path("temp.meta.gff3")
	allf = open(temp_all_file, 'w')
	metf = open(temp_meta_file, 'w')


	print(gff_header.strip(), file=allf)
	print(gff_header.strip(), file=metf)


	clusters.sort(key= lambda x: x['start'])
	clusters = [c for c in clusters if c['contig'] in gff_contigs]
	clusters.sort(key= lambda x: gff_contigs.index(x['contig']))

	cluster_i = 0
	for cluster in clusters:

		# print()
		# print('all lines')
		cluster_i += 1
		metalocus = f"{abbv}-{ds}-{cluster_i}"

		n_projects    = len(set([l['project'] for l in cluster['loci']]))
		n_annotations = len(set([(l['project'], l['annotation']) for l in cluster['loci']]))
		n_loci        = len(cluster['loci'])

		cluster['loci'].sort(key=lambda x: x['rpkm'])
		c = Counter()
		c1 = Counter()


		for l in cluster['loci']:

			l['sizecall'] = sorted(list(l['sizecall']))

			if 0 in l['sizecall']:
				sc = "N"
				feature_type = 'OtherRNA'
			else:
				sc = "_".join(map(str, l['sizecall']))
				feature_type = f'RNA_{sc}'

			c[sc] += 1
			for s in l['sizecall']:
				c1[s] += 1

			attrs =  f"ID={l['ID']}-{l['project']}-{l['annotation']};metalocus={metalocus};project={l['project']};annotation={l['annotation']};annotation_conditions={l['annotation_conditions']};sizecall={sc};depth={l['depth']};rpm={l['rpm']};rpkm={l['rpkm']};fracTop={l['fracTop']};complexity={l['complexity']};skew={l['skew']};majorRNA={l['majorRNA']}"

			gff_line = [cluster['contig'], 'yasma_locus', feature_type, str(l['start']), str(l['stop']), '.', l['strand'], '.', attrs]

			# print("\t".join(gff_line))
			print("\t".join(gff_line), file=allf)



		median_depth = median([l['depth'] for l in cluster['loci']])

		sc = c.most_common()[0][0]
		if sc == 'N':
			feature_type = 'OtherRNA'
		else:
			feature_type = f'RNA_{sc}'

		if c1.most_common()[0][0] == 0:
			sc1 = 'N'
		else:
			keys = [k for k,v in c1.items() if v == c1.most_common()[0][1]]
			sc1 = keys[len(keys) // 2]


		attrs = f"ID={metalocus};member_projects={n_projects};member_annotations={n_annotations};member_loci={n_loci};primary={cluster['primary']};rep_locus={l['ID']}-{l['project']}-{l['annotation']};sizecall={sc};sizecall_single={sc1};depth={l['depth']};median_depth={median_depth};rpm={l['rpm']};rpkm={l['rpkm']};fracTop={l['fracTop']};complexity={l['complexity']};skew={l['skew']};majorRNA={l['majorRNA']}"

		gff_line = [cluster['contig'], 'yasma_locus', feature_type, str(cluster['start']), str(cluster['stop']), '.', l['strand'], '.', attrs]

		# print()
		# print('meta line')
		# print("\t".join(gff_line))
		print("\t".join(gff_line), file=metf)


		# print()
		# print(n_projects, 'projects')
		# print(n_annotations, 'annotations')
		# print(n_loci, 'loci')
		# print()
		# input()


	allf.close()
	metf.close()


	# bedtools_sort(temp_meta_file)
	# bedtools_sort(temp_all_file)

	temp_meta_file.rename(Path(meta_folder, f"{abbv}.meta.gff3"))
	temp_all_file.rename(Path(meta_folder, f"{abbv}.all.gff3"))


