#!/bin/bash

mkdir ../annotations/Hicap.PRJNA514312
cd ../annotations/Hicap.PRJNA514312

echo Hicap.PRJNA514312.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




