#!/bin/bash

mkdir ../annotations/Asfum.PRJNA926984
cd ../annotations/Asfum.PRJNA926984

echo Asfum.PRJNA926984


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA926984.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR23205001:A SRR23205002:A SRR23205000:A SRR23204997:B SRR23204998:B SRR23204999:B SRR23204996:C SRR23204994:C SRR23204995:C -a /scratch/njohnson/Asfum.PRJNA926984.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Asfum.PRJNA926984.bam
rm /scratch/njohnson/Asfum.PRJNA926984.bam.bai
rm /scratch/njohnson/Asfum.PRJNA926984.depth.txt



