#!/bin/bash

mkdir ../annotations/Necra.PRJNA196947
cd ../annotations/Necra.PRJNA196947

echo Necra.PRJNA196947.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




