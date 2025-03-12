#!/bin/bash

mkdir ../annotations/Vealb.PRJNA213313
cd ../annotations/Vealb.PRJNA213313

echo Vealb.PRJNA213313


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Vealb.PRJNA213313.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR943043:A -a /scratch/njohnson/Vealb.PRJNA213313.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Vealb.PRJNA213313.bam
rm /scratch/njohnson/Vealb.PRJNA213313.bam.bai
rm /scratch/njohnson/Vealb.PRJNA213313.depth.txt



