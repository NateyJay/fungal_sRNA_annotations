#!/bin/bash

mkdir ../annotations/Scpom.PRJNA321172
cd ../annotations/Scpom.PRJNA321172

echo Scpom.PRJNA321172


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA321172.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR3494745:A SRR3494743:A -a /scratch/njohnson/Scpom.PRJNA321172.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA321172.bam
rm /scratch/njohnson/Scpom.PRJNA321172.bam.bai
rm /scratch/njohnson/Scpom.PRJNA321172.depth.txt



