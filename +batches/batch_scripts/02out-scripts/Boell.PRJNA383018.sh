#!/bin/bash

mkdir ../annotations/Boell.PRJNA383018
cd ../annotations/Boell.PRJNA383018

echo Boell.PRJNA383018


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Boell.PRJNA383018.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR5450818:A SRR5450817:B SRR5450816:C -a /scratch/njohnson/Boell.PRJNA383018.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Boell.PRJNA383018.bam
rm /scratch/njohnson/Boell.PRJNA383018.bam.bai
rm /scratch/njohnson/Boell.PRJNA383018.depth.txt



