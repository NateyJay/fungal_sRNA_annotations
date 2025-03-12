#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA481323
cd ../annotations/Rhirr.PRJNA481323

echo Rhirr.PRJNA481323


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA481323.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac C D -c SRR7525701:C SRR7525700:C SRR7525699:C SRR7525692:D SRR7525691:D SRR7525690:D -a /scratch/njohnson/Rhirr.PRJNA481323.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Rhirr.PRJNA481323.bam
rm /scratch/njohnson/Rhirr.PRJNA481323.bam.bai
rm /scratch/njohnson/Rhirr.PRJNA481323.depth.txt



