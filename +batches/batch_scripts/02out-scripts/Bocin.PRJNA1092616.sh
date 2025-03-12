#!/bin/bash

mkdir ../annotations/Bocin.PRJNA1092616
cd ../annotations/Bocin.PRJNA1092616

echo Bocin.PRJNA1092616


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA1092616.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR28472517:A SRR28472519:A SRR28472518:A -a /scratch/njohnson/Bocin.PRJNA1092616.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA1092616.bam
rm /scratch/njohnson/Bocin.PRJNA1092616.bam.bai
rm /scratch/njohnson/Bocin.PRJNA1092616.depth.txt



