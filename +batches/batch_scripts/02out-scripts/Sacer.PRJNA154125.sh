#!/bin/bash

mkdir ../annotations/Sacer.PRJNA154125
cd ../annotations/Sacer.PRJNA154125

echo Sacer.PRJNA154125


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Sacer.PRJNA154125.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR332049:A -a /scratch/njohnson/Sacer.PRJNA154125.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Sacer.PRJNA154125.bam
rm /scratch/njohnson/Sacer.PRJNA154125.bam.bai
rm /scratch/njohnson/Sacer.PRJNA154125.depth.txt



