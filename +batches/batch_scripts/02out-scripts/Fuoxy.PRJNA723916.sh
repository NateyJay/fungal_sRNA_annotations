#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA723916
cd ../annotations/Fuoxy.PRJNA723916

echo Fuoxy.PRJNA723916


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA723916.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR14311542:A SRR14311540:A SRR14311543:B SRR14311541:B -a /scratch/njohnson/Fuoxy.PRJNA723916.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fuoxy.PRJNA723916.bam
rm /scratch/njohnson/Fuoxy.PRJNA723916.bam.bai
rm /scratch/njohnson/Fuoxy.PRJNA723916.depth.txt



