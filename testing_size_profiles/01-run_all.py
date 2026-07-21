import sys
from pprint import pprint

from subprocess import Popen, PIPE
from pathlib import Path



annotation_dir = Path("../+annotations")
project_dirs = list(annotation_dir.glob("*"))
project_dirs.sort()


with open("01out-compiled_peaks.txt", 'w') as outf:
	for project_dir in project_dirs:
		print(project_dir)


		call = f"yasma.py size-profile -o {str(project_dir)}"
		p = Popen(call, shell=True, stdout=PIPE, stderr=PIPE, encoding='utf-8')
		out, err = p.communicate()

		print(err)


		size_plot_file = Path(project_dir, 'align','alignment.peak_plot.txt')
		if not size_plot_file.is_file():
			print(size_plot_file, 'not found!!')
			continue

		print("", file=outf)
		print(project_dir, file=outf)

		with open(size_plot_file, 'r') as f:
			for line in f:
				print(line.strip(), file=outf)