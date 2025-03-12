#!/bin/bash

mkdir ../annotations/Rhirr.PRJEB29180
cd ../annotations/Rhirr.PRJEB29180

echo Rhirr.PRJEB29180.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJEB29180.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Rhirr.PRJEB29180.B.bam
rm /scratch/njohnson/Rhirr.PRJEB29180.B.bam



