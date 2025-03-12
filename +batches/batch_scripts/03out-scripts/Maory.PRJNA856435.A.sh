#!/bin/bash

mkdir ../annotations/Maory.PRJNA856435
cd ../annotations/Maory.PRJNA856435

echo Maory.PRJNA856435.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




