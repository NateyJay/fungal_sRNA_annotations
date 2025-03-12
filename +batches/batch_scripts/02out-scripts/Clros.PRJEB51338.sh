#!/bin/bash

mkdir ../annotations/Clros.PRJEB51338
cd ../annotations/Clros.PRJEB51338

echo Clros.PRJEB51338


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Clros.PRJEB51338.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F -c ERR9187519:A ERR9187599:A ERR9187621:A ERR9187521:A ERR9175317:B ERR9185330:B ERR9187055:B ERR9179355:B ERR9230637:C ERR9167744:C ERR9147845:C ERR9132653:C ERR9127135:D ERR9130475:D ERR9128394:D ERR9130362:D ERR9122364:E ERR9126957:E ERR9126315:E ERR9127134:E ERR9122112:F ERR9078345:F ERR9121006:F ERR9078297:F -a /scratch/njohnson/Clros.PRJEB51338.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Clros.PRJEB51338.bam
rm /scratch/njohnson/Clros.PRJEB51338.bam.bai
rm /scratch/njohnson/Clros.PRJEB51338.depth.txt



