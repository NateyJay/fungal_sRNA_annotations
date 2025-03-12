#!/bin/bash

mkdir ../annotations/Fugra.PRJNA683746
cd ../annotations/Fugra.PRJNA683746

echo Fugra.PRJNA683746.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




