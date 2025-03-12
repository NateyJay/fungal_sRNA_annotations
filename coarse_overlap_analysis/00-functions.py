
import sys
import pysam



def check_coarse_overlap(gff, bam):



	bamf = pysam.AlignmentFile(bam, "rb")	

	if not bamf.has_index():
		print(f'   index not found for {bam}. Indexing with samtools.')

		pysam.index(str(bam))
		bamf.close()
		bamf = pysam.AlignmentFile(bam,'rb')


	## getting overall alignment counts
	total_reads   = 0
	total_aligned = 0
	for l in pysam.idxstats(bam).strip().split("\n"):
		l = l.strip().split("\t")
		total_reads   += int(l[2])
		total_reads   += int(l[3])
		total_aligned += int(l[2])


	gene_d = {}

	last_chrom = ''
	last_stop  = 0


	gene_aligned          = 0
	gene_aligned_stranded = 0


	with open(gff, 'r') as f:
		for line in f:

			line = line.strip().split("\t")

			if len(line) < 3 or line[2] != 'gene':
				## filtering for gff 'gene''
				continue

			chrom  = line[0]
			start  = int(line[3])
			stop   = int(line[4])
			strand = line[6]

			if chrom == last_chrom and start < last_stop:
				## fiiltering gff entries that might overlap
				continue



			for read in bamf.fetch(contig=chrom, start=start, stop=stop):

				read_strand = "+" if read.is_forward else "-"

				gene_aligned += 1
				if strand == read_strand:
					gene_aligned_stranded += 1


			last_chrom = chrom
			last_stop  = stop
			

	bamf.close()

	return(total_reads, total_aligned, gene_aligned, gene_aligned_stranded)


total_reads, total_aligned, gene_aligned, gene_aligned_stranded = check_coarse_overlap('Bocin.GCF_000143535.2_ASM14353v4_genomic.gff', 'alignment.bam')

# print(total_reads, total_aligned, gene_aligned, gene_aligned_stranded)
