#!/bin/bash

mkdir ../annotations/Vamal.PRJNA413773
cd ../annotations/Vamal.PRJNA413773

echo Vamal.PRJNA413773


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Vamal.PRJNA413773.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR6153307:A SRR6153308:A -a /scratch/njohnson/Vamal.PRJNA413773.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Vamal.PRJNA413773.bam
rm /scratch/njohnson/Vamal.PRJNA413773.bam.bai
rm /scratch/njohnson/Vamal.PRJNA413773.depth.txt



