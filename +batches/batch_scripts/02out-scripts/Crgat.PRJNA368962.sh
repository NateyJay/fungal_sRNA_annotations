#!/bin/bash

mkdir ../annotations/Crgat.PRJNA368962
cd ../annotations/Crgat.PRJNA368962

echo Crgat.PRJNA368962


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Crgat.PRJNA368962.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR5209175:A -a /scratch/njohnson/Crgat.PRJNA368962.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Crgat.PRJNA368962.bam
rm /scratch/njohnson/Crgat.PRJNA368962.bam.bai
rm /scratch/njohnson/Crgat.PRJNA368962.depth.txt



