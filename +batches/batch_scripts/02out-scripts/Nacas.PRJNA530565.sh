#!/bin/bash

mkdir ../annotations/Nacas.PRJNA530565
cd ../annotations/Nacas.PRJNA530565

echo Nacas.PRJNA530565


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Nacas.PRJNA530565.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR9711187:A SRR9711188:A -a /scratch/njohnson/Nacas.PRJNA530565.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Nacas.PRJNA530565.bam
rm /scratch/njohnson/Nacas.PRJNA530565.bam.bai
rm /scratch/njohnson/Nacas.PRJNA530565.depth.txt



