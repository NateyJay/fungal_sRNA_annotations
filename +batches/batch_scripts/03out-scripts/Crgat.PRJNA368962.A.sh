#!/bin/bash

mkdir ../annotations/Crgat.PRJNA368962
cd ../annotations/Crgat.PRJNA368962

echo Crgat.PRJNA368962.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




