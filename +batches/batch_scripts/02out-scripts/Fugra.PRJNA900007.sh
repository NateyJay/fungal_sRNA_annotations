#!/bin/bash

mkdir ../annotations/Fugra.PRJNA900007
cd ../annotations/Fugra.PRJNA900007

echo Fugra.PRJNA900007


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA900007.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A F G -c SRR22252427:A SRR22252441:F SRR22252442:F SRR22252443:G -a /scratch/njohnson/Fugra.PRJNA900007.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fugra.PRJNA900007.bam
rm /scratch/njohnson/Fugra.PRJNA900007.bam.bai
rm /scratch/njohnson/Fugra.PRJNA900007.depth.txt



