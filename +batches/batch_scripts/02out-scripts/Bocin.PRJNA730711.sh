#!/bin/bash

mkdir ../annotations/Bocin.PRJNA730711
cd ../annotations/Bocin.PRJNA730711

echo Bocin.PRJNA730711


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA730711.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F -c SRR14576256:A SRR14576255:B SRR14576254:C SRR14576253:D SRR14576252:E SRR14576251:F -a /scratch/njohnson/Bocin.PRJNA730711.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA730711.bam
rm /scratch/njohnson/Bocin.PRJNA730711.bam.bai
rm /scratch/njohnson/Bocin.PRJNA730711.depth.txt



