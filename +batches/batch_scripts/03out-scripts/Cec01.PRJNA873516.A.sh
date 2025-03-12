#!/bin/bash

mkdir ../annotations/Cec01.PRJNA873516
cd ../annotations/Cec01.PRJNA873516

echo Cec01.PRJNA873516.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




