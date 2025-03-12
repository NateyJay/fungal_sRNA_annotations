



from pathlib import Path

from pprint import pprint
import sys




txt_files = [p for p in Path(".").glob("*/*.txt")]
print()
# print(txt_files)

def get_read_idx(line):

	left  = len(line) - len(line.lstrip("-"))
	right = len(line.rstrip("-"))

	return(left, right)


with open("01out-alt_stars.txt", 'w') as outf:

	print('abbv', 'hp_type', 'ml', 'project', 'cond', 'pl', 'sub', 'mas', 'star', 'star_depth', 'star_prop', 'alt_star', 'alt_depth', 'alt_prop', 'alt_overlap', 'left_offset', 'right_offset', sep='\t', file=outf)

	for file in txt_files:

		hp_type = file.parents[0]
		abbv    = file.name[:5]
		ml      = "-".join(file.name.split("-")[:2])
		pl      = file.name.split("-")[2]
		project = file.name.split("-")[3]
		cond    = file.name.split('-')[-1].split(".")[0]
		sub     = file.name.split(".")[-2]
		if "PRJ" in sub:
			sub = ''

		print(file)

		with open(file, 'r') as f:

			seq  = f.readline().strip()
			fold = f.readline().strip()

			if "A" not in seq:
				print("   ^^^ looks broken")
				continue

			# print(len(seq))
			# print([seq], "<- seq")


			f.readline()
			f.readline()
			f.readline()

			mas, mas_depth, _ = f.readline().strip().split()
			mas_depth = int(mas_depth)

			print(mas, mas_depth)
			star, star_depth, _ = f.readline().strip().split()
			star_depth = int(star_depth)

			star_left, star_right = get_read_idx(star)

			f.readline()
			f.readline()

			best_alt_star = None
			best_alt_star_depth = 0
			best_alt_star_overlap = 0

			for line in f:

				line, line_depth = line.strip().split()
				line_depth = int(line_depth)

				line_left, line_right = get_read_idx(line)

				overlap = range(max(line_left, star_left), min(line_right, star_right))



				if len(overlap) > 0:

					if line_depth > star_depth and line_depth > best_alt_star_depth:
						# print(line, line_depth)
						best_alt_star = line
						best_alt_star_depth = line_depth
						best_alt_star_overlap = len(overlap)
						# print(best_alt_star_depth)



			if best_alt_star:


				# print(seq)
				# print(fold)
				# print(mas, mas_depth, "<- mas")
				# print(star, star_depth, "<- star")
				# print(best_alt_star, best_alt_star_depth, "<- best_alt_star")

				best_left, best_right = get_read_idx(best_alt_star)

				left_offset  = best_left  - star_left
				right_offset = best_right - star_right


				best_alt_star = best_alt_star.strip("-")

				try:
					alt_star_prop = best_alt_star_depth / mas_depth

				except ZeroDivisionError:
					print("  ^^^ badly formed hairpin file (why is mas at depth zero??)")
					alt_star_prop = "ERROR"

			else:


				left_offset = None
				right_offset = None
				alt_star_prop = None

			try:
				star_prop = star_depth / mas_depth

			except ZeroDivisionError:
				print("  ^^^ badly formed hairpin file (why is mas at depth zero??)")
				star_prop = "ERROR"

			star = star.strip("-")
			mas = mas.strip('-')

			print(abbv, hp_type, ml, project, cond, pl, sub, mas, star, star_depth, star_prop, best_alt_star, best_alt_star_depth, alt_star_prop, best_alt_star_overlap, left_offset, right_offset, sep='\t', file=outf)





