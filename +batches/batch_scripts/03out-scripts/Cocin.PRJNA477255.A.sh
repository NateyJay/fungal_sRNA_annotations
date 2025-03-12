#!/bin/bash

mkdir ../annotations/Cocin.PRJNA477255
cd ../annotations/Cocin.PRJNA477255

echo Cocin.PRJNA477255.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




