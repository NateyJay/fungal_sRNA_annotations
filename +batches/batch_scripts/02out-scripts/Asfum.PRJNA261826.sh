#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261826
cd ../annotations/Asfum.PRJNA261826

echo Asfum.PRJNA261826


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261826.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR1583954:A SRR1583953:B SRR1583952:C -a /scratch/njohnson/Asfum.PRJNA261826.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Asfum.PRJNA261826.bam
rm /scratch/njohnson/Asfum.PRJNA261826.bam.bai
rm /scratch/njohnson/Asfum.PRJNA261826.depth.txt



