#!/bin/bash

mkdir ../annotations/Vedah.PRJNA787244
cd ../annotations/Vedah.PRJNA787244

echo Vedah.PRJNA787244


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Vedah.PRJNA787244.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR17168772:A SRR17168773:A -a /scratch/njohnson/Vedah.PRJNA787244.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Vedah.PRJNA787244.bam
rm /scratch/njohnson/Vedah.PRJNA787244.bam.bai
rm /scratch/njohnson/Vedah.PRJNA787244.depth.txt



