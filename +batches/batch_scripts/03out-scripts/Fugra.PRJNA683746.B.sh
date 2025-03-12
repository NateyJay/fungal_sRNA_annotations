#!/bin/bash

mkdir ../annotations/Fugra.PRJNA683746
cd ../annotations/Fugra.PRJNA683746

echo Fugra.PRJNA683746.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




