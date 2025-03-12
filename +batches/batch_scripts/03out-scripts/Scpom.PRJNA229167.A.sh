#!/bin/bash

mkdir ../annotations/Scpom.PRJNA229167
cd ../annotations/Scpom.PRJNA229167

echo Scpom.PRJNA229167.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




