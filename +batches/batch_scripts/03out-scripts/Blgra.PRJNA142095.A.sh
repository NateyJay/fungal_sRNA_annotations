#!/bin/bash

mkdir ../annotations/Blgra.PRJNA142095
cd ../annotations/Blgra.PRJNA142095

echo Blgra.PRJNA142095.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




