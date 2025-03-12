#!/bin/bash

mkdir ../annotations/Atrol.PRJNA486707
cd ../annotations/Atrol.PRJNA486707

echo Atrol.PRJNA486707.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




