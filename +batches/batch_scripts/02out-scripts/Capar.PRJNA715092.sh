#!/bin/bash

mkdir ../annotations/Capar.PRJNA715092
cd ../annotations/Capar.PRJNA715092

echo Capar.PRJNA715092


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Capar.PRJNA715092.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac D C F E -c SRR13986631:D SRR13986632:D SRR13986633:D SRR13986638:C SRR13986639:C SRR13986640:C SRR13986647:F SRR13986649:F SRR13986650:F SRR13986654:E SRR13986655:E SRR13986656:E -a /scratch/njohnson/Capar.PRJNA715092.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Capar.PRJNA715092.bam
rm /scratch/njohnson/Capar.PRJNA715092.bam.bai
rm /scratch/njohnson/Capar.PRJNA715092.depth.txt



