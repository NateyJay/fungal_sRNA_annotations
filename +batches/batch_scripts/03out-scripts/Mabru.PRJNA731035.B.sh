#!/bin/bash

mkdir ../annotations/Mabru.PRJNA731035
cd ../annotations/Mabru.PRJNA731035

echo Mabru.PRJNA731035.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




