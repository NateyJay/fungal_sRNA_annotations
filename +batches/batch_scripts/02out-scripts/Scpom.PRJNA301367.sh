#!/bin/bash

mkdir ../annotations/Scpom.PRJNA301367
cd ../annotations/Scpom.PRJNA301367

echo Scpom.PRJNA301367


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA301367.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR2927733:A -a /scratch/njohnson/Scpom.PRJNA301367.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA301367.bam
rm /scratch/njohnson/Scpom.PRJNA301367.bam.bai
rm /scratch/njohnson/Scpom.PRJNA301367.depth.txt



