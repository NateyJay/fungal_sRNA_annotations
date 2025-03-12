#!/bin/bash

mkdir ../annotations/Necra.PRJNA190099
cd ../annotations/Necra.PRJNA190099

echo Necra.PRJNA190099


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA190099.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F -c SRR769610:A SRR769748:B SRR756354:C SRR756251:D SRR755946:E SRR751454:F -a /scratch/njohnson/Necra.PRJNA190099.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Necra.PRJNA190099.bam
rm /scratch/njohnson/Necra.PRJNA190099.bam.bai
rm /scratch/njohnson/Necra.PRJNA190099.depth.txt



