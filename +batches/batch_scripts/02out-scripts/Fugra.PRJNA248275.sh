#!/bin/bash

mkdir ../annotations/Fugra.PRJNA248275
cd ../annotations/Fugra.PRJNA248275

echo Fugra.PRJNA248275


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA248275.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR1293689:A SRR1293690:B SRR1293691:C -a /scratch/njohnson/Fugra.PRJNA248275.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fugra.PRJNA248275.bam
rm /scratch/njohnson/Fugra.PRJNA248275.bam.bai
rm /scratch/njohnson/Fugra.PRJNA248275.depth.txt



