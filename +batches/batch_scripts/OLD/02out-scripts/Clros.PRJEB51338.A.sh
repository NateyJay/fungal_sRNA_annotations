#!/bin/bash

mkdir ../annotations/Clros.PRJEB51338
cd ../annotations/Clros.PRJEB51338

echo Clros.PRJEB51338.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Clros.PRJEB51338.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Clros.PRJEB51338.A.bam
rm /scratch/njohnson/Clros.PRJEB51338.A.bam



