#!/bin/bash

mkdir ../annotations/Asfla.PRJNA438019
cd ../annotations/Asfla.PRJNA438019

echo Asfla.PRJNA438019


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Asfla.PRJNA438019.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR6828228:A SRR6828236:A SRR6828243:B SRR6828241:B -a /scratch/njohnson/Asfla.PRJNA438019.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Asfla.PRJNA438019.bam
rm /scratch/njohnson/Asfla.PRJNA438019.bam.bai
rm /scratch/njohnson/Asfla.PRJNA438019.depth.txt



