#!/bin/bash

mkdir ../annotations/Cec01.PRJNA873516
cd ../annotations/Cec01.PRJNA873516

echo Cec01.PRJNA873516


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Cec01.PRJNA873516.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR21284932:A SRR21285828:A SRR21284931:A SRR21284929:B SRR21284928:B SRR21284930:B -a /scratch/njohnson/Cec01.PRJNA873516.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Cec01.PRJNA873516.bam
rm /scratch/njohnson/Cec01.PRJNA873516.bam.bai
rm /scratch/njohnson/Cec01.PRJNA873516.depth.txt



