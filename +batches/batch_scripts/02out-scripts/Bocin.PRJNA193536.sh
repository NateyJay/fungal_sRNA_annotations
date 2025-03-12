#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193536
cd ../annotations/Bocin.PRJNA193536

echo Bocin.PRJNA193536


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193536.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac D E F G -c SRR786984:D SRR786983:E SRR786982:F SRR786981:G -a /scratch/njohnson/Bocin.PRJNA193536.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA193536.bam
rm /scratch/njohnson/Bocin.PRJNA193536.bam.bai
rm /scratch/njohnson/Bocin.PRJNA193536.depth.txt



