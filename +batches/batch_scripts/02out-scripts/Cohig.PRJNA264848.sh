#!/bin/bash

mkdir ../annotations/Cohig.PRJNA264848
cd ../annotations/Cohig.PRJNA264848

echo Cohig.PRJNA264848


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Cohig.PRJNA264848.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR1630071:A SRR1630069:A SRR1630070:A SRR1630068:B SRR1630067:B SRR1630066:B -a /scratch/njohnson/Cohig.PRJNA264848.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Cohig.PRJNA264848.bam
rm /scratch/njohnson/Cohig.PRJNA264848.bam.bai
rm /scratch/njohnson/Cohig.PRJNA264848.depth.txt



