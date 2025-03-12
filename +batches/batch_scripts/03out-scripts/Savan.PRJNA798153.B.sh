#!/bin/bash

mkdir ../annotations/Savan.PRJNA798153
cd ../annotations/Savan.PRJNA798153

echo Savan.PRJNA798153.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




