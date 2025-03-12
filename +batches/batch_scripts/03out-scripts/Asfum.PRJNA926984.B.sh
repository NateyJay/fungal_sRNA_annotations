#!/bin/bash

mkdir ../annotations/Asfum.PRJNA926984
cd ../annotations/Asfum.PRJNA926984

echo Asfum.PRJNA926984.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




