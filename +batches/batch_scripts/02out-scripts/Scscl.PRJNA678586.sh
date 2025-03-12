#!/bin/bash

mkdir ../annotations/Scscl.PRJNA678586
cd ../annotations/Scscl.PRJNA678586

echo Scscl.PRJNA678586


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA678586.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR13071041:A SRR13071040:A SRR13071042:A -a /scratch/njohnson/Scscl.PRJNA678586.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scscl.PRJNA678586.bam
rm /scratch/njohnson/Scscl.PRJNA678586.bam.bai
rm /scratch/njohnson/Scscl.PRJNA678586.depth.txt



