#!/bin/bash

mkdir ../annotations/Crneo.PRJNA629419
cd ../annotations/Crneo.PRJNA629419

echo Crneo.PRJNA629419.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




