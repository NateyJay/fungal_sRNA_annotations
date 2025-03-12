#!/bin/bash

mkdir ../annotations/Tratr.PRJNA508370
cd ../annotations/Tratr.PRJNA508370

echo Tratr.PRJNA508370.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




