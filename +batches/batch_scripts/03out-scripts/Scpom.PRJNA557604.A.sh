#!/bin/bash

mkdir ../annotations/Scpom.PRJNA557604
cd ../annotations/Scpom.PRJNA557604

echo Scpom.PRJNA557604.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




