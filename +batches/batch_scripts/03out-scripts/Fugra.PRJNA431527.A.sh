#!/bin/bash

mkdir ../annotations/Fugra.PRJNA431527
cd ../annotations/Fugra.PRJNA431527

echo Fugra.PRJNA431527.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




