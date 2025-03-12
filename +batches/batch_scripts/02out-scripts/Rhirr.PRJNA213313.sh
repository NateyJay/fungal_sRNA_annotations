#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA213313
cd ../annotations/Rhirr.PRJNA213313

echo Rhirr.PRJNA213313


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA213313.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac C -c SRR943039:C -a /scratch/njohnson/Rhirr.PRJNA213313.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Rhirr.PRJNA213313.bam
rm /scratch/njohnson/Rhirr.PRJNA213313.bam.bai
rm /scratch/njohnson/Rhirr.PRJNA213313.depth.txt



