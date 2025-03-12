#!/bin/bash

mkdir ../annotations/Sacer.PRJNA154125
cd ../annotations/Sacer.PRJNA154125

echo Sacer.PRJNA154125.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




