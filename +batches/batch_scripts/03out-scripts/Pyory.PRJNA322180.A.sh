#!/bin/bash

mkdir ../annotations/Pyory.PRJNA322180
cd ../annotations/Pyory.PRJNA322180

echo Pyory.PRJNA322180.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




