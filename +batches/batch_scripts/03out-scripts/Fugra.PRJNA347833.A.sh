#!/bin/bash

mkdir ../annotations/Fugra.PRJNA347833
cd ../annotations/Fugra.PRJNA347833

echo Fugra.PRJNA347833.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




