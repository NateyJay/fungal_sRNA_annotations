#!/bin/bash

mkdir ../annotations/Scscl.PRJNA659617
cd ../annotations/Scscl.PRJNA659617

echo Scscl.PRJNA659617


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA659617.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR12527895:A SRR12527894:A SRR12527896:B SRR12527897:B SRR12527899:C SRR12527898:C -a /scratch/njohnson/Scscl.PRJNA659617.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scscl.PRJNA659617.bam
rm /scratch/njohnson/Scscl.PRJNA659617.bam.bai
rm /scratch/njohnson/Scscl.PRJNA659617.depth.txt



