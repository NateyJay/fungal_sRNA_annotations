#!/bin/bash

mkdir ../annotations/Mucir.PRJNA200295
cd ../annotations/Mucir.PRJNA200295

echo Mucir.PRJNA200295.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




