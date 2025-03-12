#!/bin/bash

mkdir ../annotations/Pugra.PRJNA960906
cd ../annotations/Pugra.PRJNA960906

echo Pugra.PRJNA960906


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Pugra.PRJNA960906.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR24282674:A SRR24282673:A SRR24282675:A -a /scratch/njohnson/Pugra.PRJNA960906.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Pugra.PRJNA960906.bam
rm /scratch/njohnson/Pugra.PRJNA960906.bam.bai
rm /scratch/njohnson/Pugra.PRJNA960906.depth.txt



