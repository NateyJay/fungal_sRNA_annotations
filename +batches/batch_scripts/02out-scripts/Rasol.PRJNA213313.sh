#!/bin/bash

mkdir ../annotations/Rasol.PRJNA213313
cd ../annotations/Rasol.PRJNA213313

echo Rasol.PRJNA213313


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Rasol.PRJNA213313.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac B -c SRR943041:B -a /scratch/njohnson/Rasol.PRJNA213313.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Rasol.PRJNA213313.bam
rm /scratch/njohnson/Rasol.PRJNA213313.bam.bai
rm /scratch/njohnson/Rasol.PRJNA213313.depth.txt



