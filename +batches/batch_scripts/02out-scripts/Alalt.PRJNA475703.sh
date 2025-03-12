#!/bin/bash

mkdir ../annotations/Alalt.PRJNA475703
cd ../annotations/Alalt.PRJNA475703

echo Alalt.PRJNA475703


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Alalt.PRJNA475703.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR7294210:A SRR7294208:A SRR7294207:B SRR7294209:B -a /scratch/njohnson/Alalt.PRJNA475703.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Alalt.PRJNA475703.bam
rm /scratch/njohnson/Alalt.PRJNA475703.bam.bai
rm /scratch/njohnson/Alalt.PRJNA475703.depth.txt



