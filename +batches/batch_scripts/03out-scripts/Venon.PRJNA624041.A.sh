#!/bin/bash

mkdir ../annotations/Venon.PRJNA624041
cd ../annotations/Venon.PRJNA624041

echo Venon.PRJNA624041.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




