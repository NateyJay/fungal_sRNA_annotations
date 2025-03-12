#!/bin/bash

mkdir ../annotations/Culun.PRJNA769949
cd ../annotations/Culun.PRJNA769949

echo Culun.PRJNA769949.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Culun.PRJNA769949.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Culun.PRJNA769949.B.bam
rm /scratch/njohnson/Culun.PRJNA769949.B.bam



