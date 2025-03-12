#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA310070.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F G H -c SRR3130367:A SRR3130368:B SRR3130369:C SRR3130370:D SRR3130371:E SRR3130372:F SRR3130373:G SRR3130374:H -a /scratch/njohnson/Maory.PRJNA310070.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Maory.PRJNA310070.bam
rm /scratch/njohnson/Maory.PRJNA310070.bam.bai
rm /scratch/njohnson/Maory.PRJNA310070.depth.txt



