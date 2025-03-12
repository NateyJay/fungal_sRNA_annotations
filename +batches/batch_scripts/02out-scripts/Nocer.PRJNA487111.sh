#!/bin/bash

mkdir ../annotations/Nocer.PRJNA487111
cd ../annotations/Nocer.PRJNA487111

echo Nocer.PRJNA487111


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Nocer.PRJNA487111.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR7741650:A SRR7741652:A SRR7741651:A SRR7741655:B SRR7741649:B SRR7741656:B -a /scratch/njohnson/Nocer.PRJNA487111.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Nocer.PRJNA487111.bam
rm /scratch/njohnson/Nocer.PRJNA487111.bam.bai
rm /scratch/njohnson/Nocer.PRJNA487111.depth.txt



