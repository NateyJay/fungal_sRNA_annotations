#!/bin/bash

mkdir ../annotations/Fugra.PRJNA431527
cd ../annotations/Fugra.PRJNA431527

echo Fugra.PRJNA431527


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA431527.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR21707787:A SRR21708809:A SRR6516242:B SRR6516243:B SRR6516244:C SRR6516245:C -a /scratch/njohnson/Fugra.PRJNA431527.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fugra.PRJNA431527.bam
rm /scratch/njohnson/Fugra.PRJNA431527.bam.bai
rm /scratch/njohnson/Fugra.PRJNA431527.depth.txt



