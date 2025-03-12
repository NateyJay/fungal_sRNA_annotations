#!/bin/bash

mkdir ../annotations/Capar.PRJNA715092
cd ../annotations/Capar.PRJNA715092

echo Capar.PRJNA715092.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




