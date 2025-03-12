#!/bin/bash

mkdir ../annotations/Labic.PRJNA481323
cd ../annotations/Labic.PRJNA481323

echo Labic.PRJNA481323


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Labic.PRJNA481323.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR7525707:A SRR7525706:A SRR7525705:A SRR7525697:B SRR7525698:B SRR7525696:B -a /scratch/njohnson/Labic.PRJNA481323.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Labic.PRJNA481323.bam
rm /scratch/njohnson/Labic.PRJNA481323.bam.bai
rm /scratch/njohnson/Labic.PRJNA481323.depth.txt



