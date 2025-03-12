#!/bin/bash

mkdir ../annotations/Scscl.PRJNA379694
cd ../annotations/Scscl.PRJNA379694

echo Scscl.PRJNA379694


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA379694.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR8306349:A SRR8306350:A -a /scratch/njohnson/Scscl.PRJNA379694.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scscl.PRJNA379694.bam
rm /scratch/njohnson/Scscl.PRJNA379694.bam.bai
rm /scratch/njohnson/Scscl.PRJNA379694.depth.txt



