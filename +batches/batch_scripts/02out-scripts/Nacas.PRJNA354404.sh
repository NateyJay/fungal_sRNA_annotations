#!/bin/bash

mkdir ../annotations/Nacas.PRJNA354404
cd ../annotations/Nacas.PRJNA354404

echo Nacas.PRJNA354404


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Nacas.PRJNA354404.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR8838455:A SRR8838454:A -a /scratch/njohnson/Nacas.PRJNA354404.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Nacas.PRJNA354404.bam
rm /scratch/njohnson/Nacas.PRJNA354404.bam.bai
rm /scratch/njohnson/Nacas.PRJNA354404.depth.txt



