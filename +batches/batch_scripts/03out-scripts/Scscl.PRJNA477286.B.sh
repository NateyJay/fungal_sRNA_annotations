#!/bin/bash

mkdir ../annotations/Scscl.PRJNA477286
cd ../annotations/Scscl.PRJNA477286

echo Scscl.PRJNA477286.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




