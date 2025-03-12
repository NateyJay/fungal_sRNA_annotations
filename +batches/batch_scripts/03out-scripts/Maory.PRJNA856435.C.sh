#!/bin/bash

mkdir ../annotations/Maory.PRJNA856435
cd ../annotations/Maory.PRJNA856435

echo Maory.PRJNA856435.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




