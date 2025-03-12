#!/bin/bash

mkdir ../annotations/Rhirr.PRJEB29180
cd ../annotations/Rhirr.PRJEB29180

echo Rhirr.PRJEB29180.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJEB29180.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Rhirr.PRJEB29180.A.bam
rm /scratch/njohnson/Rhirr.PRJEB29180.A.bam



