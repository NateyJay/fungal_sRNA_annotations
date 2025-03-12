#!/bin/bash

mkdir ../annotations/Meacr.PRJNA688941
cd ../annotations/Meacr.PRJNA688941

echo Meacr.PRJNA688941


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Meacr.PRJNA688941.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR13347136:A SRR13347133:A SRR13347135:A SRR13347134:B SRR13347131:B SRR13347132:B -a /scratch/njohnson/Meacr.PRJNA688941.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Meacr.PRJNA688941.bam
rm /scratch/njohnson/Meacr.PRJNA688941.bam.bai
rm /scratch/njohnson/Meacr.PRJNA688941.depth.txt



