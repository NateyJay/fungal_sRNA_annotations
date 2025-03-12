#!/bin/bash

mkdir ../annotations/Masym.PRJNA342612
cd ../annotations/Masym.PRJNA342612

echo Masym.PRJNA342612


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Masym.PRJNA342612.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR4237864:A SRR4237857:A SRR4237858:A SRR4237863:A SRR4237866:A SRR4237862:B SRR4237865:B SRR4237861:B SRR4237859:B SRR4237860:B -a /scratch/njohnson/Masym.PRJNA342612.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Masym.PRJNA342612.bam
rm /scratch/njohnson/Masym.PRJNA342612.bam.bai
rm /scratch/njohnson/Masym.PRJNA342612.depth.txt



