#!/bin/bash

mkdir ../annotations/Hicap.PRJNA514312
cd ../annotations/Hicap.PRJNA514312

echo Hicap.PRJNA514312.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




