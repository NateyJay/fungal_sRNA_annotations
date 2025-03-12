#!/bin/bash

mkdir ../annotations/Mucir.PRJNA200295
cd ../annotations/Mucir.PRJNA200295

echo Mucir.PRJNA200295


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Mucir.PRJNA200295.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR1576768:A -a /scratch/njohnson/Mucir.PRJNA200295.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Mucir.PRJNA200295.bam
rm /scratch/njohnson/Mucir.PRJNA200295.bam.bai
rm /scratch/njohnson/Mucir.PRJNA200295.depth.txt



