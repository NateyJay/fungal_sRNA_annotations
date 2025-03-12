#!/bin/bash

mkdir ../annotations/Comil.PRJNA496418
cd ../annotations/Comil.PRJNA496418

echo Comil.PRJNA496418


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Comil.PRJNA496418.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR8054055:A SRR8054060:A SRR8054056:A SRR8054057:B SRR8054058:B SRR8054059:B -a /scratch/njohnson/Comil.PRJNA496418.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Comil.PRJNA496418.bam
rm /scratch/njohnson/Comil.PRJNA496418.bam.bai
rm /scratch/njohnson/Comil.PRJNA496418.depth.txt



