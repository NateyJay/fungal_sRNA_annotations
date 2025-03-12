#!/bin/bash

mkdir ../annotations/Albra.PRJNA556655
cd ../annotations/Albra.PRJNA556655

echo Albra.PRJNA556655


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Albra.PRJNA556655.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR9833419:A SRR9833418:B -a /scratch/njohnson/Albra.PRJNA556655.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Albra.PRJNA556655.bam
rm /scratch/njohnson/Albra.PRJNA556655.bam.bai
rm /scratch/njohnson/Albra.PRJNA556655.depth.txt



