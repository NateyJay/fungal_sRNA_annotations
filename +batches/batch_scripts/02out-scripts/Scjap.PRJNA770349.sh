#!/bin/bash

mkdir ../annotations/Scjap.PRJNA770349
cd ../annotations/Scjap.PRJNA770349

echo Scjap.PRJNA770349


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scjap.PRJNA770349.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR16291984:A SRR16291985:A -a /scratch/njohnson/Scjap.PRJNA770349.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scjap.PRJNA770349.bam
rm /scratch/njohnson/Scjap.PRJNA770349.bam.bai
rm /scratch/njohnson/Scjap.PRJNA770349.depth.txt



