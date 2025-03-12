#!/bin/bash

mkdir ../annotations/Scpom.PRJNA321172
cd ../annotations/Scpom.PRJNA321172

echo Scpom.PRJNA321172.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




