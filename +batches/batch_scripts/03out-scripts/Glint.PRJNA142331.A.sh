#!/bin/bash

mkdir ../annotations/Glint.PRJNA142331
cd ../annotations/Glint.PRJNA142331

echo Glint.PRJNA142331.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




