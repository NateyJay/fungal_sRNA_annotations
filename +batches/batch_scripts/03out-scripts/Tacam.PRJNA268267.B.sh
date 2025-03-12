#!/bin/bash

mkdir ../annotations/Tacam.PRJNA268267
cd ../annotations/Tacam.PRJNA268267

echo Tacam.PRJNA268267.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




