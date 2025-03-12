#!/bin/bash

mkdir ../annotations/Scpom.PRJNA259168
cd ../annotations/Scpom.PRJNA259168

echo Scpom.PRJNA259168.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




