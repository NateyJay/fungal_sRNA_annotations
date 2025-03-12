#!/bin/bash

mkdir ../annotations/Spsci.PRJNA322114
cd ../annotations/Spsci.PRJNA322114

echo Spsci.PRJNA322114.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




