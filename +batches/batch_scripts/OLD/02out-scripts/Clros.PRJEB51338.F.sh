#!/bin/bash

mkdir ../annotations/Clros.PRJEB51338
cd ../annotations/Clros.PRJEB51338

echo Clros.PRJEB51338.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Clros.PRJEB51338.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Clros.PRJEB51338.F.bam
rm /scratch/njohnson/Clros.PRJEB51338.F.bam



