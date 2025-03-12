#!/bin/bash

mkdir ../annotations/Sacer.PRJNA154129
cd ../annotations/Sacer.PRJNA154129

echo Sacer.PRJNA154129


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Sacer.PRJNA154129.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR332256:A SRR332256:A -a /scratch/njohnson/Sacer.PRJNA154129.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Sacer.PRJNA154129.bam
rm /scratch/njohnson/Sacer.PRJNA154129.bam.bai
rm /scratch/njohnson/Sacer.PRJNA154129.depth.txt



