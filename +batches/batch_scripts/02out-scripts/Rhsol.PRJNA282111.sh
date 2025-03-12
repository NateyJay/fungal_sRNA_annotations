#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA282111
cd ../annotations/Rhsol.PRJNA282111

echo Rhsol.PRJNA282111


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA282111.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F G -c SRR1994871:A SRR1994872:B SRR1994873:C SRR1994874:D SRR1994875:E SRR1994876:F SRR1994877:G -a /scratch/njohnson/Rhsol.PRJNA282111.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Rhsol.PRJNA282111.bam
rm /scratch/njohnson/Rhsol.PRJNA282111.bam.bai
rm /scratch/njohnson/Rhsol.PRJNA282111.depth.txt



