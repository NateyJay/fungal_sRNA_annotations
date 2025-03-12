#!/bin/bash

mkdir ../annotations/Necra.PRJNA350329
cd ../annotations/Necra.PRJNA350329

echo Necra.PRJNA350329


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA350329.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR4448064:A -a /scratch/njohnson/Necra.PRJNA350329.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Necra.PRJNA350329.bam
rm /scratch/njohnson/Necra.PRJNA350329.bam.bai
rm /scratch/njohnson/Necra.PRJNA350329.depth.txt



