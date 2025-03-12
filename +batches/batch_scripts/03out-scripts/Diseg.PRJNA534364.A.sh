#!/bin/bash

mkdir ../annotations/Diseg.PRJNA534364
cd ../annotations/Diseg.PRJNA534364

echo Diseg.PRJNA534364.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




