#!/bin/bash

mkdir ../annotations/Scscl.PRJNA477286
cd ../annotations/Scscl.PRJNA477286

echo Scscl.PRJNA477286.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




