#!/bin/bash

mkdir ../annotations/Coglo.PRJNA490143
cd ../annotations/Coglo.PRJNA490143

echo Coglo.PRJNA490143


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Coglo.PRJNA490143.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR7814092:A SRR7814094:A SRR7814093:A -a /scratch/njohnson/Coglo.PRJNA490143.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Coglo.PRJNA490143.bam
rm /scratch/njohnson/Coglo.PRJNA490143.bam.bai
rm /scratch/njohnson/Coglo.PRJNA490143.depth.txt



