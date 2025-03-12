#!/bin/bash

mkdir ../annotations/Scscl.PRJNA348385
cd ../annotations/Scscl.PRJNA348385

echo Scscl.PRJNA348385.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




