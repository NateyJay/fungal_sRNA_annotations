#!/bin/bash

mkdir ../annotations/Rhjg1.PRJNA631292
cd ../annotations/Rhjg1.PRJNA631292

echo Rhjg1.PRJNA631292


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Rhjg1.PRJNA631292.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F -c SRR11784190:A SRR11784199:B SRR11784198:C SRR11784193:D SRR11784192:E SRR11784191:F -a /scratch/njohnson/Rhjg1.PRJNA631292.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Rhjg1.PRJNA631292.bam
rm /scratch/njohnson/Rhjg1.PRJNA631292.bam.bai
rm /scratch/njohnson/Rhjg1.PRJNA631292.depth.txt



