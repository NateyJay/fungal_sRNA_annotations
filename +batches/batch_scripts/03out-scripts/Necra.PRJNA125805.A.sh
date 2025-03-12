#!/bin/bash

mkdir ../annotations/Necra.PRJNA125805
cd ../annotations/Necra.PRJNA125805

echo Necra.PRJNA125805.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




