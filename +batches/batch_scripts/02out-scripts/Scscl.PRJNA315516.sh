#!/bin/bash

mkdir ../annotations/Scscl.PRJNA315516
cd ../annotations/Scscl.PRJNA315516

echo Scscl.PRJNA315516


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA315516.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR3383805:A SRR3383815:A SRR3383816:A -a /scratch/njohnson/Scscl.PRJNA315516.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scscl.PRJNA315516.bam
rm /scratch/njohnson/Scscl.PRJNA315516.bam.bai
rm /scratch/njohnson/Scscl.PRJNA315516.depth.txt



