#!/bin/bash

mkdir ../annotations/Bebas.PRJNA517599
cd ../annotations/Bebas.PRJNA517599

echo Bebas.PRJNA517599.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




