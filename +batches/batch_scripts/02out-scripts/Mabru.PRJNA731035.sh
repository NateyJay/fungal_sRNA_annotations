#!/bin/bash

mkdir ../annotations/Mabru.PRJNA731035
cd ../annotations/Mabru.PRJNA731035

echo Mabru.PRJNA731035


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Mabru.PRJNA731035.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR14586322:A SRR14586326:A SRR14586325:A SRR14586319:B SRR14586320:B SRR14586321:B SRR14586318:C SRR14586317:C SRR14586316:C SRR14586315:D SRR14586324:D SRR14586323:D -a /scratch/njohnson/Mabru.PRJNA731035.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Mabru.PRJNA731035.bam
rm /scratch/njohnson/Mabru.PRJNA731035.bam.bai
rm /scratch/njohnson/Mabru.PRJNA731035.depth.txt



