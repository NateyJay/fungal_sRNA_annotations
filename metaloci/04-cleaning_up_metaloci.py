import sys
import pprint
from collections import Counter
import numpy as np
from math import log10
from statistics import median, mean
np.set_printoptions(threshold=np.inf)
np.set_printoptions(linewidth=300)

import matplotlib.pyplot as plt

from sklearn.cluster import DBSCAN, HDBSCAN

loc_d = {}

with open("./01out-meta_gffs/Bocin.all.gff3", 'r') as f:
	for line in f:

		if line.startswith("#"):
			continue

		line = line.split("\t")

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
		d['fracTop'] = float(d['fracTop'])
		d['length'] = d['stop'] - d['start']

		sc = set([int(l) if l.isdigit() else 0 for l in d['sizecall'].split("_")])

		if max(sc) <= 19 or min(sc) >= 30:
			sc = set([0])

		d['sizecall'] = sc

		try:
			loc_d[d['metalocus']].append(d)
		except KeyError:
			loc_d[d['metalocus']] = [d]




## trying to build an average metalocus



def get_median_boundaries(metalocus):
	loci = loc_d[metalocus]
	loci.sort(key=lambda x: x['rpm'], reverse=True)

	pos_c = Counter()




	for d in loci:
		for r in range(d['start'], d['stop']+1):
			pos_c[r] += 1


	i_start = loci[0]['start']
	i_stop  = loci[0]['stop']




	def get_avg_overlap(start, stop):
		length = stop - start

		props = []
		for l in loci:

			l_start, l_stop = l['start'], l['stop']
			l_length = l_stop - l_start
			combined_length = max([stop, l_stop]) - min([start, l_start])



			left  = l_start - start
			right = l_stop - stop

			if right < -1 * l_length or left > l_length:
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
			# print('boundaries:', start, '-', stop)
			# print("locus:", l_start, '-', l_stop)
			# print(l_error, r_error)
			# print('overlap:', overlap)
			# print('length:', length)
			# print('combined_length:', combined_length)
			# print('prop:', prop)

			if prop < 0:
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


	for resolution in [50, 10, 1]:
		while True:
			score, ldir, rdir = try_directions(i_start, i_stop, inc=resolution)
			if ldir == 0 and ldir == 0:
				break

			i_start += resolution * ldir
			i_stop  += resolution * rdir
			print(" ", resolution, i_start, i_stop, score, sep='\t')

	return(metalocus, loci[0]['contig'], i_start, i_stop, score)



print(get_median_boundaries("Bocin-7643"))
print(get_median_boundaries("Bocin-1921"))


sys.exit()


max_depth = max(pos_c.values())
deep_enough = False
sub_meta = 0

def check_deep_enough(v):
	return v >= 5


for r in range(min(list(pos_c.keys())), max(list(pos_c.keys()))+1):
	prop = round(pos_c[r] / max_depth,4)

	print(r, pos_c[r], prop, sep='\t')

	# if check_deep_enough(pos_c[r]) and not deep_enough:
	# 	print()
	# 	sub_meta += 1
	# deep_enough = check_deep_enough(pos_c[r])

	# if deep_enough:
	# 	print(r, pos_c[r], prop, f"sub_meta_{sub_meta}", sep='\t')






sys.exit()
'''trying to cluster... maybe a bad idea. Overlaps, mixed metrics make it very hard to know what is real. Best to average'''
metaloci = ['Bocin-7643', "Bocin-20835", "Bocin-20836", "Bocin-20837", "Bocin-20838"]

loci = []
for m in metaloci:
	loci += loc_d[m]


# def overlap_distance(l1, l2):
	# r1 = set(range(l1['start'], l1['stop']+1))
	# r2 = set(range(l2['start'], l2['stop']+1))

# 	largest = max([len(l1), len(l2)])

# 	return(len(r1 & r2) / largest * 5)

def positional_distance(l1, l2):
	r1 = set(range(l1['start'], l1['stop']+1))
	r2 = set(range(l2['start'], l2['stop']+1))

	if r1 & r2:
		return 0

	distance = min([abs(max(r1) - min(r2)), abs(max(r2) - min(r1))])
	return distance / 500

def length_distance(l1, l2):
	l1 = l1['length']
	l2 = l2['length']

	return abs(l1 - l2) / 500


def rpm_distance(l1, l2):

	rpms = [l1['rpm'], l2['rpm']]
	rpms.sort()

	return(abs(log10(min(rpms) / max(rpms))))

def strand_distance(l1, l2):

	return(abs(l1['fracTop'] - l2['fracTop']) / 0.5)

def sizecall_distance(l1, l2):

	sc1 = l1['sizecall']
	sc2 = l2['sizecall']

	if sc1 == sc2:
		return 0 

	elif sc1.issubset(sc2) or sc2.issubset(sc1):
		return 0

	elif len(sc1 & sc2) == 0:
		return (50)

	else:
		return (len(sc1 | sc2) -  len(sc1 & sc2))





dist = [
	[[positional_distance(l1, l2) for l1 in loci] for l2 in loci],
	[[length_distance(l1, l2) for l1 in loci] for l2 in loci],
	[[rpm_distance(l1, l2) for l1 in loci] for l2 in loci],
	[[strand_distance(l1, l2) for l1 in loci] for l2 in loci],
	[[sizecall_distance(l1, l2) for l1 in loci] for l2 in loci],
]

dist = np.array(dist)

print(dist.shape)
dist = np.sum(dist, 0)

print(dist.shape)

hdb = HDBSCAN()

hdb.fit(dist)

print(hdb.labels_)
print(hdb.probabilities_)

for cluster in range(1, hdb.labels_.max()+1):

	print('\ncluster', cluster)

	ii = [i for i,c in enumerate(hdb.labels_) if c == cluster]

	for i in ii:
		l = loci[i]
		print(l['ID'], l['sizecall'], l['start'], l['stop'], l['strand'], sep='\t')


sys.exit()






