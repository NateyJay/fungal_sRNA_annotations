#!/bin/bash

mkdir ../annotations/Plost.PRJNA448380
cd ../annotations/Plost.PRJNA448380

echo Plost.PRJNA448380


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Plost.PRJNA448380.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F -c SRR6926089:A SRR6926090:A SRR6926088:A SRR6926082:B SRR6926081:B SRR6926080:B SRR6926073:C SRR6926072:C SRR6926071:C SRR6926055:D SRR6926054:D SRR6926053:D SRR6926045:E SRR6926046:E SRR6926044:E SRR6926063:F SRR6926064:F SRR6926062:F -a /scratch/njohnson/Plost.PRJNA448380.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Plost.PRJNA448380.bam
rm /scratch/njohnson/Plost.PRJNA448380.bam.bai
rm /scratch/njohnson/Plost.PRJNA448380.depth.txt



