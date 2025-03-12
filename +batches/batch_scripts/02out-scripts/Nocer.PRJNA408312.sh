#!/bin/bash

mkdir ../annotations/Nocer.PRJNA408312
cd ../annotations/Nocer.PRJNA408312

echo Nocer.PRJNA408312


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Nocer.PRJNA408312.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR6059173:A SRR6059172:A SRR6059166:A SRR6059167:B SRR6059171:B SRR6059164:B -a /scratch/njohnson/Nocer.PRJNA408312.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Nocer.PRJNA408312.bam
rm /scratch/njohnson/Nocer.PRJNA408312.bam.bai
rm /scratch/njohnson/Nocer.PRJNA408312.depth.txt



