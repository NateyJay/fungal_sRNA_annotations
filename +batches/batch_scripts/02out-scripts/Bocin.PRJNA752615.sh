#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F G H I J K L M N O P -c SRR15361397:A SRR15361398:B SRR15361399:C SRR15361400:D SRR15361401:E SRR15361402:F SRR15361403:G SRR15361404:H SRR15361405:I SRR15361406:J SRR15361407:K SRR15361408:L SRR15361409:M SRR15361410:N SRR15361411:O SRR15361412:P -a /scratch/njohnson/Bocin.PRJNA752615.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA752615.bam
rm /scratch/njohnson/Bocin.PRJNA752615.bam.bai
rm /scratch/njohnson/Bocin.PRJNA752615.depth.txt



