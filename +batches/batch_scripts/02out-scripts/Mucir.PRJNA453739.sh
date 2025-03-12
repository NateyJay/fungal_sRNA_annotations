#!/bin/bash

mkdir ../annotations/Mucir.PRJNA453739
cd ../annotations/Mucir.PRJNA453739

echo Mucir.PRJNA453739


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Mucir.PRJNA453739.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR7068271:A SRR7068276:A -a /scratch/njohnson/Mucir.PRJNA453739.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Mucir.PRJNA453739.bam
rm /scratch/njohnson/Mucir.PRJNA453739.bam.bai
rm /scratch/njohnson/Mucir.PRJNA453739.depth.txt



