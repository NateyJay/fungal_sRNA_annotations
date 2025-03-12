#!/bin/bash

mkdir ../annotations/Mabru.PRJNA731035
cd ../annotations/Mabru.PRJNA731035

echo Mabru.PRJNA731035.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




