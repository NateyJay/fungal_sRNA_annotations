#!/bin/bash

mkdir ../annotations/Blgra.PRJNA479878
cd ../annotations/Blgra.PRJNA479878

echo Blgra.PRJNA479878


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Blgra.PRJNA479878.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR7475546:A -a /scratch/njohnson/Blgra.PRJNA479878.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Blgra.PRJNA479878.bam
rm /scratch/njohnson/Blgra.PRJNA479878.bam.bai
rm /scratch/njohnson/Blgra.PRJNA479878.depth.txt



