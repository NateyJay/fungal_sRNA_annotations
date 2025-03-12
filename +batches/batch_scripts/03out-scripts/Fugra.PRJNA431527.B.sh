#!/bin/bash

mkdir ../annotations/Fugra.PRJNA431527
cd ../annotations/Fugra.PRJNA431527

echo Fugra.PRJNA431527.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




