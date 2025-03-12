#!/bin/bash

mkdir ../annotations/Scpom.PRJNA259172
cd ../annotations/Scpom.PRJNA259172

echo Scpom.PRJNA259172


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA259172.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac B C D E -c SRR1555771:B SRR1555771:B SRR1555769:C SRR1555769:C SRR1555770:D SRR1555770:D SRR1555768:D SRR1555768:D SRR1555766:E SRR1555766:E -a /scratch/njohnson/Scpom.PRJNA259172.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA259172.bam
rm /scratch/njohnson/Scpom.PRJNA259172.bam.bai
rm /scratch/njohnson/Scpom.PRJNA259172.depth.txt



