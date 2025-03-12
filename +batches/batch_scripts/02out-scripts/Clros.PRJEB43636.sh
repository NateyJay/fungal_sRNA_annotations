#!/bin/bash

mkdir ../annotations/Clros.PRJEB43636
cd ../annotations/Clros.PRJEB43636

echo Clros.PRJEB43636


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Clros.PRJEB43636.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac C F -c ERR5960091:C ERR5960110:C ERR5960111:C ERR5961147:C ERR5950791:F ERR5950921:F ERR5950930:F ERR5950932:F ERR5950923:F ERR5950927:F -a /scratch/njohnson/Clros.PRJEB43636.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Clros.PRJEB43636.bam
rm /scratch/njohnson/Clros.PRJEB43636.bam.bai
rm /scratch/njohnson/Clros.PRJEB43636.depth.txt



