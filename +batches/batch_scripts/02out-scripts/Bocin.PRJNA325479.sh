#!/bin/bash

mkdir ../annotations/Bocin.PRJNA325479
cd ../annotations/Bocin.PRJNA325479

echo Bocin.PRJNA325479


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA325479.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR3659827:A SRR3659826:B SRR3659825:C -a /scratch/njohnson/Bocin.PRJNA325479.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA325479.bam
rm /scratch/njohnson/Bocin.PRJNA325479.bam.bai
rm /scratch/njohnson/Bocin.PRJNA325479.depth.txt



