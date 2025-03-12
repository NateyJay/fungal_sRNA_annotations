#!/bin/bash

mkdir ../annotations/Blgra.PRJNA476756
cd ../annotations/Blgra.PRJNA476756

echo Blgra.PRJNA476756


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Blgra.PRJNA476756.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E -c SRR7363329:A SRR7363330:A SRR7363328:A SRR7363332:B SRR7363333:B SRR7363331:B SRR7363334:C SRR7363336:C SRR7363335:C SRR7363339:D SRR7363337:D SRR7363338:D SRR7363340:E SRR7363341:E SRR7363342:E -a /scratch/njohnson/Blgra.PRJNA476756.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Blgra.PRJNA476756.bam
rm /scratch/njohnson/Blgra.PRJNA476756.bam.bai
rm /scratch/njohnson/Blgra.PRJNA476756.depth.txt



