#!/bin/bash

mkdir ../annotations/Vedah.PRJNA198742
cd ../annotations/Vedah.PRJNA198742

echo Vedah.PRJNA198742


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Vedah.PRJNA198742.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR833802:A -a /scratch/njohnson/Vedah.PRJNA198742.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Vedah.PRJNA198742.bam
rm /scratch/njohnson/Vedah.PRJNA198742.bam.bai
rm /scratch/njohnson/Vedah.PRJNA198742.depth.txt



