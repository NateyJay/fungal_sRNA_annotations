#!/bin/bash

mkdir ../annotations/Venon.PRJNA624041
cd ../annotations/Venon.PRJNA624041

echo Venon.PRJNA624041


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Venon.PRJNA624041.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR11514758:A SRR11514754:A SRR11514755:A SRR11514759:A SRR11514756:A SRR11514760:A SRR11514757:A SRR11514761:A -a /scratch/njohnson/Venon.PRJNA624041.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Venon.PRJNA624041.bam
rm /scratch/njohnson/Venon.PRJNA624041.bam.bai
rm /scratch/njohnson/Venon.PRJNA624041.depth.txt



