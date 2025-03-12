#!/bin/bash

mkdir ../annotations/Savan.PRJNA798153
cd ../annotations/Savan.PRJNA798153

echo Savan.PRJNA798153.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




