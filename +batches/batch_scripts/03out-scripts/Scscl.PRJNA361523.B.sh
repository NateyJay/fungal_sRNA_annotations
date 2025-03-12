#!/bin/bash

mkdir ../annotations/Scscl.PRJNA361523
cd ../annotations/Scscl.PRJNA361523

echo Scscl.PRJNA361523.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




