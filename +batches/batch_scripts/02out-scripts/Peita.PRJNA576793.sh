#!/bin/bash

mkdir ../annotations/Peita.PRJNA576793
cd ../annotations/Peita.PRJNA576793

echo Peita.PRJNA576793


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Peita.PRJNA576793.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR10257020:A SRR10257021:A SRR10257022:A -a /scratch/njohnson/Peita.PRJNA576793.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Peita.PRJNA576793.bam
rm /scratch/njohnson/Peita.PRJNA576793.bam.bai
rm /scratch/njohnson/Peita.PRJNA576793.depth.txt



