#!/bin/bash

mkdir ../annotations/Clros.PRJEB51338
cd ../annotations/Clros.PRJEB51338

echo Clros.PRJEB51338.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Clros.PRJEB51338.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Clros.PRJEB51338.E.bam
rm /scratch/njohnson/Clros.PRJEB51338.E.bam



