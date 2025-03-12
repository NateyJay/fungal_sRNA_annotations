#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA329032
cd ../annotations/Fuoxy.PRJNA329032

echo Fuoxy.PRJNA329032


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA329032.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR3921571:A SRR3921570:B -a /scratch/njohnson/Fuoxy.PRJNA329032.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fuoxy.PRJNA329032.bam
rm /scratch/njohnson/Fuoxy.PRJNA329032.bam.bai
rm /scratch/njohnson/Fuoxy.PRJNA329032.depth.txt



