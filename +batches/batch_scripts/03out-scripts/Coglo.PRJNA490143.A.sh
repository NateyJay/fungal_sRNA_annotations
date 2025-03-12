#!/bin/bash

mkdir ../annotations/Coglo.PRJNA490143
cd ../annotations/Coglo.PRJNA490143

echo Coglo.PRJNA490143.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




