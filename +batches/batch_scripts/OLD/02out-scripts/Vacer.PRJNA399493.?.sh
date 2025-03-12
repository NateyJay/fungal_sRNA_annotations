#!/bin/bash

mkdir ../annotations/Vacer.PRJNA399493
cd ../annotations/Vacer.PRJNA399493

echo Vacer.PRJNA399493.?

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vacer.PRJNA399493.?.bam
yasma.py tradeoff -o . -n ? -ac ? -a /scratch/njohnson/Vacer.PRJNA399493.?.bam
rm /scratch/njohnson/Vacer.PRJNA399493.?.bam



