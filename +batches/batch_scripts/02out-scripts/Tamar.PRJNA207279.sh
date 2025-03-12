#!/bin/bash

mkdir ../annotations/Tamar.PRJNA207279
cd ../annotations/Tamar.PRJNA207279

echo Tamar.PRJNA207279


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Tamar.PRJNA207279.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR922412:A SRR906436:A -a /scratch/njohnson/Tamar.PRJNA207279.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Tamar.PRJNA207279.bam
rm /scratch/njohnson/Tamar.PRJNA207279.bam.bai
rm /scratch/njohnson/Tamar.PRJNA207279.depth.txt



