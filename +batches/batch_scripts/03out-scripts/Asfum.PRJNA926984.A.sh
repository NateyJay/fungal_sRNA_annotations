#!/bin/bash

mkdir ../annotations/Asfum.PRJNA926984
cd ../annotations/Asfum.PRJNA926984

echo Asfum.PRJNA926984.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




