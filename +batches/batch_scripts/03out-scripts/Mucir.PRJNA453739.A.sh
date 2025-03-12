#!/bin/bash

mkdir ../annotations/Mucir.PRJNA453739
cd ../annotations/Mucir.PRJNA453739

echo Mucir.PRJNA453739.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




