#!/bin/bash

mkdir ../annotations/Nobom.PRJNA953616
cd ../annotations/Nobom.PRJNA953616

echo Nobom.PRJNA953616.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




