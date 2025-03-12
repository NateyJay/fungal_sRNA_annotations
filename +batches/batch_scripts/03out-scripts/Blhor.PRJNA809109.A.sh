#!/bin/bash

mkdir ../annotations/Blhor.PRJNA809109
cd ../annotations/Blhor.PRJNA809109

echo Blhor.PRJNA809109.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




