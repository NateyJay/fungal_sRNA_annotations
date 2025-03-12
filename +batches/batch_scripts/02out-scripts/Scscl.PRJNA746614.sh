#!/bin/bash

mkdir ../annotations/Scscl.PRJNA746614
cd ../annotations/Scscl.PRJNA746614

echo Scscl.PRJNA746614


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA746614.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR15142509:A SRR15142508:A SRR15142507:A SRR15142505:B SRR15142504:B SRR15142506:B -a /scratch/njohnson/Scscl.PRJNA746614.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scscl.PRJNA746614.bam
rm /scratch/njohnson/Scscl.PRJNA746614.bam.bai
rm /scratch/njohnson/Scscl.PRJNA746614.depth.txt



