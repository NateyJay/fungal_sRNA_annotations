#!/bin/bash

mkdir ../annotations/Savan.PRJNA798153
cd ../annotations/Savan.PRJNA798153

echo Savan.PRJNA798153


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Savan.PRJNA798153.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR17649062:A SRR17649063:B -a /scratch/njohnson/Savan.PRJNA798153.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Savan.PRJNA798153.bam
rm /scratch/njohnson/Savan.PRJNA798153.bam.bai
rm /scratch/njohnson/Savan.PRJNA798153.depth.txt



