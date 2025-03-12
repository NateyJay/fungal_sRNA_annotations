#!/bin/bash

mkdir ../annotations/Maory.PRJNA185495
cd ../annotations/Maory.PRJNA185495

echo Maory.PRJNA185495


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA185495.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F G -c SRR643882:A SRR643881:B SRR643879:C SRR643878:D SRR643877:E SRR643876:F SRR643875:G -a /scratch/njohnson/Maory.PRJNA185495.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Maory.PRJNA185495.bam
rm /scratch/njohnson/Maory.PRJNA185495.bam.bai
rm /scratch/njohnson/Maory.PRJNA185495.depth.txt



