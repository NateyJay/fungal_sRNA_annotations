#!/bin/bash

mkdir ../annotations/Sacer.PRJNA154129
cd ../annotations/Sacer.PRJNA154129

echo Sacer.PRJNA154129.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




