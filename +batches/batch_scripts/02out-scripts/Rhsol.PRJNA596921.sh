#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA596921
cd ../annotations/Rhsol.PRJNA596921

echo Rhsol.PRJNA596921


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA596921.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR10747099:A SRR10747102:A -a /scratch/njohnson/Rhsol.PRJNA596921.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Rhsol.PRJNA596921.bam
rm /scratch/njohnson/Rhsol.PRJNA596921.bam.bai
rm /scratch/njohnson/Rhsol.PRJNA596921.depth.txt



