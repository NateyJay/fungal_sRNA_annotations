#!/bin/bash

mkdir ../annotations/Clros.PRJEB51338
cd ../annotations/Clros.PRJEB51338

echo Clros.PRJEB51338.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Clros.PRJEB51338.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Clros.PRJEB51338.D.bam
rm /scratch/njohnson/Clros.PRJEB51338.D.bam



