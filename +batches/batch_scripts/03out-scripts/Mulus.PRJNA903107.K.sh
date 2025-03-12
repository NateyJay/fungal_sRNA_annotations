#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.K


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n K -a tradeoff_K


echo "
"




