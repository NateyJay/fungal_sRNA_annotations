#!/bin/bash

mkdir ../annotations/Caalb.PRJNA773057
cd ../annotations/Caalb.PRJNA773057

echo Caalb.PRJNA773057


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Caalb.PRJNA773057.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR16501716:A -a /scratch/njohnson/Caalb.PRJNA773057.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Caalb.PRJNA773057.bam
rm /scratch/njohnson/Caalb.PRJNA773057.bam.bai
rm /scratch/njohnson/Caalb.PRJNA773057.depth.txt



