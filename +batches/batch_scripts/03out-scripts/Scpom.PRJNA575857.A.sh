#!/bin/bash

mkdir ../annotations/Scpom.PRJNA575857
cd ../annotations/Scpom.PRJNA575857

echo Scpom.PRJNA575857.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




