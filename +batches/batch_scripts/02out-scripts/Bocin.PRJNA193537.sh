#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193537
cd ../annotations/Bocin.PRJNA193537

echo Bocin.PRJNA193537


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193537.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR786986:A SRR786987:B SRR786988:C -a /scratch/njohnson/Bocin.PRJNA193537.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA193537.bam
rm /scratch/njohnson/Bocin.PRJNA193537.bam.bai
rm /scratch/njohnson/Bocin.PRJNA193537.depth.txt



