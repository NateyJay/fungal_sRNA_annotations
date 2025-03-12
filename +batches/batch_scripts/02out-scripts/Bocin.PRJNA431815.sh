#!/bin/bash

mkdir ../annotations/Bocin.PRJNA431815
cd ../annotations/Bocin.PRJNA431815

echo Bocin.PRJNA431815


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA431815.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR6667534:A SRR6667535:A SRR6667533:A SRR6667531:B SRR6667530:B SRR6667532:B SRR6667520:C SRR6667536:C SRR6667537:C -a /scratch/njohnson/Bocin.PRJNA431815.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA431815.bam
rm /scratch/njohnson/Bocin.PRJNA431815.bam.bai
rm /scratch/njohnson/Bocin.PRJNA431815.depth.txt



