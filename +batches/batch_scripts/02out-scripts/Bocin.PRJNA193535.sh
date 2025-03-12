#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193535
cd ../annotations/Bocin.PRJNA193535

echo Bocin.PRJNA193535


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193535.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR786978:A SRR786977:B SRR786976:C -a /scratch/njohnson/Bocin.PRJNA193535.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA193535.bam
rm /scratch/njohnson/Bocin.PRJNA193535.bam.bai
rm /scratch/njohnson/Bocin.PRJNA193535.depth.txt



