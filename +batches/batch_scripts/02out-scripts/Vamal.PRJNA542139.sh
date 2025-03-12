#!/bin/bash

mkdir ../annotations/Vamal.PRJNA542139
cd ../annotations/Vamal.PRJNA542139

echo Vamal.PRJNA542139


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Vamal.PRJNA542139.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR9103190:A SRR9035426:B -a /scratch/njohnson/Vamal.PRJNA542139.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Vamal.PRJNA542139.bam
rm /scratch/njohnson/Vamal.PRJNA542139.bam.bai
rm /scratch/njohnson/Vamal.PRJNA542139.depth.txt



