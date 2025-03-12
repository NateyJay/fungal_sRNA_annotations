#!/bin/bash

mkdir ../annotations/Petra.PRJNA742222
cd ../annotations/Petra.PRJNA742222

echo Petra.PRJNA742222


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Petra.PRJNA742222.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR14996693:A SRR14996695:A SRR14996694:A -a /scratch/njohnson/Petra.PRJNA742222.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Petra.PRJNA742222.bam
rm /scratch/njohnson/Petra.PRJNA742222.bam.bai
rm /scratch/njohnson/Petra.PRJNA742222.depth.txt



