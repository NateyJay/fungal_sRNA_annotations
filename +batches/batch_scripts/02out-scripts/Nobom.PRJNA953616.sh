#!/bin/bash

mkdir ../annotations/Nobom.PRJNA953616
cd ../annotations/Nobom.PRJNA953616

echo Nobom.PRJNA953616


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Nobom.PRJNA953616.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR24111183:A SRR24111185:A SRR24111184:A SRR24165928:A SRR24165927:A SRR24111180:B SRR24111182:B SRR24111181:B SRR24165926:B SRR24111176:C SRR24111178:C SRR24111179:C SRR24165923:C SRR24165925:C SRR24111174:D SRR24111173:D SRR24111175:D SRR24165922:D -a /scratch/njohnson/Nobom.PRJNA953616.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Nobom.PRJNA953616.bam
rm /scratch/njohnson/Nobom.PRJNA953616.bam.bai
rm /scratch/njohnson/Nobom.PRJNA953616.depth.txt



