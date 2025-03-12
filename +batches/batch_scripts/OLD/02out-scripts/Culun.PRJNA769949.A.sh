#!/bin/bash

mkdir ../annotations/Culun.PRJNA769949
cd ../annotations/Culun.PRJNA769949

echo Culun.PRJNA769949.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Culun.PRJNA769949.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Culun.PRJNA769949.A.bam
rm /scratch/njohnson/Culun.PRJNA769949.A.bam



