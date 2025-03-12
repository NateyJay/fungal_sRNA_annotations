#!/bin/bash

mkdir ../annotations/Necra.PRJNA207075
cd ../annotations/Necra.PRJNA207075

echo Necra.PRJNA207075


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA207075.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR882074:A -a /scratch/njohnson/Necra.PRJNA207075.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Necra.PRJNA207075.bam
rm /scratch/njohnson/Necra.PRJNA207075.bam.bai
rm /scratch/njohnson/Necra.PRJNA207075.depth.txt



