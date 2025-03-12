#!/bin/bash

mkdir ../annotations/Necra.PRJNA196947
cd ../annotations/Necra.PRJNA196947

echo Necra.PRJNA196947


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA196947.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR1657926:A SRR826686:B SRR826685:C SRR826684:D -a /scratch/njohnson/Necra.PRJNA196947.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Necra.PRJNA196947.bam
rm /scratch/njohnson/Necra.PRJNA196947.bam.bai
rm /scratch/njohnson/Necra.PRJNA196947.depth.txt



