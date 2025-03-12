#!/bin/bash

mkdir ../annotations/Scscl.PRJNA140539
cd ../annotations/Scscl.PRJNA140539

echo Scscl.PRJNA140539


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA140539.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR189065:A -a /scratch/njohnson/Scscl.PRJNA140539.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scscl.PRJNA140539.bam
rm /scratch/njohnson/Scscl.PRJNA140539.bam.bai
rm /scratch/njohnson/Scscl.PRJNA140539.depth.txt



