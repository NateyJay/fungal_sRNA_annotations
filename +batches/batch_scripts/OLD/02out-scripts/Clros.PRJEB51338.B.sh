#!/bin/bash

mkdir ../annotations/Clros.PRJEB51338
cd ../annotations/Clros.PRJEB51338

echo Clros.PRJEB51338.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Clros.PRJEB51338.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Clros.PRJEB51338.B.bam
rm /scratch/njohnson/Clros.PRJEB51338.B.bam



