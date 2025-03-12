#!/bin/bash

mkdir ../annotations/Rhirr.PRJEB29180
cd ../annotations/Rhirr.PRJEB29180

echo Rhirr.PRJEB29180


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJEB29180.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c ERR2841782:A ERR2841783:A ERR2841784:A ERR2841786:B ERR2841787:B ERR2841785:B -a /scratch/njohnson/Rhirr.PRJEB29180.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Rhirr.PRJEB29180.bam
rm /scratch/njohnson/Rhirr.PRJEB29180.bam.bai
rm /scratch/njohnson/Rhirr.PRJEB29180.depth.txt



