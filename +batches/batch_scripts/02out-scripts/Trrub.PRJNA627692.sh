#!/bin/bash

mkdir ../annotations/Trrub.PRJNA627692
cd ../annotations/Trrub.PRJNA627692

echo Trrub.PRJNA627692


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Trrub.PRJNA627692.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR11599830:A SRR11599828:A SRR11599829:A -a /scratch/njohnson/Trrub.PRJNA627692.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Trrub.PRJNA627692.bam
rm /scratch/njohnson/Trrub.PRJNA627692.bam.bai
rm /scratch/njohnson/Trrub.PRJNA627692.depth.txt



