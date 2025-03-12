#!/bin/bash

mkdir ../annotations/Pustr.PRJNA289147
cd ../annotations/Pustr.PRJNA289147

echo Pustr.PRJNA289147


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Pustr.PRJNA289147.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A C D -c SRR19441421:A SRR19441424:A SRR19441423:A SRR19441422:A SRR2094581:C SRR2094580:C SRR2094579:C SRR2094492:D SRR2094565:D SRR2094566:D -a /scratch/njohnson/Pustr.PRJNA289147.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Pustr.PRJNA289147.bam
rm /scratch/njohnson/Pustr.PRJNA289147.bam.bai
rm /scratch/njohnson/Pustr.PRJNA289147.depth.txt



