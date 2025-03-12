#!/bin/bash

mkdir ../annotations/Focan.PRJNA705837
cd ../annotations/Focan.PRJNA705837

echo Focan.PRJNA705837.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




