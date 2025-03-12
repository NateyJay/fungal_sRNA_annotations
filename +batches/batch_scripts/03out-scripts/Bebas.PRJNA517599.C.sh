#!/bin/bash

mkdir ../annotations/Bebas.PRJNA517599
cd ../annotations/Bebas.PRJNA517599

echo Bebas.PRJNA517599.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




