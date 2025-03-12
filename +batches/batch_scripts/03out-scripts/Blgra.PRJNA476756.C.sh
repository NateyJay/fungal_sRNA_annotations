#!/bin/bash

mkdir ../annotations/Blgra.PRJNA476756
cd ../annotations/Blgra.PRJNA476756

echo Blgra.PRJNA476756.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




