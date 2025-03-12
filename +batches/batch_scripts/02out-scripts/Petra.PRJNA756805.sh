#!/bin/bash

mkdir ../annotations/Petra.PRJNA756805
cd ../annotations/Petra.PRJNA756805

echo Petra.PRJNA756805


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Petra.PRJNA756805.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR15607207:A SRR15607208:A SRR15607209:A -a /scratch/njohnson/Petra.PRJNA756805.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Petra.PRJNA756805.bam
rm /scratch/njohnson/Petra.PRJNA756805.bam.bai
rm /scratch/njohnson/Petra.PRJNA756805.depth.txt



