#!/bin/bash

mkdir ../annotations/Scscl.PRJNA659617
cd ../annotations/Scscl.PRJNA659617

echo Scscl.PRJNA659617.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




