#!/bin/bash

mkdir ../annotations/Agbis.PRJNA770841
cd ../annotations/Agbis.PRJNA770841

echo Agbis.PRJNA770841


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Agbis.PRJNA770841.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR16308470:A -a /scratch/njohnson/Agbis.PRJNA770841.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Agbis.PRJNA770841.bam
rm /scratch/njohnson/Agbis.PRJNA770841.bam.bai
rm /scratch/njohnson/Agbis.PRJNA770841.depth.txt



