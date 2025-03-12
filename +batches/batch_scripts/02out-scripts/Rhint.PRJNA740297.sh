#!/bin/bash

mkdir ../annotations/Rhint.PRJNA740297
cd ../annotations/Rhint.PRJNA740297

echo Rhint.PRJNA740297


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Rhint.PRJNA740297.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR15685446:A SRR15685442:A SRR15685445:A SRR15685443:A SRR15685467:B SRR15685455:B SRR15685466:B SRR15685444:B SRR15685451:C SRR15685454:C SRR15685453:C SRR15685452:C SRR15685465:D SRR15685463:D SRR15685461:D SRR15685462:D SRR15685464:D -a /scratch/njohnson/Rhint.PRJNA740297.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Rhint.PRJNA740297.bam
rm /scratch/njohnson/Rhint.PRJNA740297.bam.bai
rm /scratch/njohnson/Rhint.PRJNA740297.depth.txt



