#!/bin/bash

mkdir ../annotations/Fugra.PRJNA248275
cd ../annotations/Fugra.PRJNA248275

echo Fugra.PRJNA248275.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




