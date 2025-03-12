#!/bin/bash

mkdir ../annotations/Vovol.PRJNA594834
cd ../annotations/Vovol.PRJNA594834

echo Vovol.PRJNA594834


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Vovol.PRJNA594834.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR10727288:A SRR10727296:A SRR10727297:A SRR10727289:B SRR10727290:B SRR10727291:B SRR10727292:C SRR10727293:C SRR10727294:C SRR10727299:D SRR10727298:D SRR10727295:D -a /scratch/njohnson/Vovol.PRJNA594834.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Vovol.PRJNA594834.bam
rm /scratch/njohnson/Vovol.PRJNA594834.bam.bai
rm /scratch/njohnson/Vovol.PRJNA594834.depth.txt



