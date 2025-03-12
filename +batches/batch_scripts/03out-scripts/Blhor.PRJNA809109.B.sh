#!/bin/bash

mkdir ../annotations/Blhor.PRJNA809109
cd ../annotations/Blhor.PRJNA809109

echo Blhor.PRJNA809109.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




