#!/bin/bash

mkdir ../annotations/Necra.PRJNA196947
cd ../annotations/Necra.PRJNA196947

echo Necra.PRJNA196947.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




