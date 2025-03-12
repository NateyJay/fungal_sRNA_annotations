#!/bin/bash

mkdir ../annotations/Scpom.PRJNA438370
cd ../annotations/Scpom.PRJNA438370

echo Scpom.PRJNA438370.?


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n ? -a tradeoff_?


echo "
"




