#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA472169
cd ../annotations/Fuoxy.PRJNA472169

echo Fuoxy.PRJNA472169


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA472169.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR7187364:A SRR7187367:A SRR7187371:A SRR7187368:B SRR7187372:B SRR7187365:B SRR7187369:C SRR7187360:C SRR7187373:C SRR7187374:D SRR7187361:D SRR7187362:D -a /scratch/njohnson/Fuoxy.PRJNA472169.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fuoxy.PRJNA472169.bam
rm /scratch/njohnson/Fuoxy.PRJNA472169.bam.bai
rm /scratch/njohnson/Fuoxy.PRJNA472169.depth.txt



