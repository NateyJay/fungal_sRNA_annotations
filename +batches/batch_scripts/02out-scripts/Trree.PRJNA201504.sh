#!/bin/bash

mkdir ../annotations/Trree.PRJNA201504
cd ../annotations/Trree.PRJNA201504

echo Trree.PRJNA201504


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Trree.PRJNA201504.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR847118:A SRR847119:B -a /scratch/njohnson/Trree.PRJNA201504.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Trree.PRJNA201504.bam
rm /scratch/njohnson/Trree.PRJNA201504.bam.bai
rm /scratch/njohnson/Trree.PRJNA201504.depth.txt



