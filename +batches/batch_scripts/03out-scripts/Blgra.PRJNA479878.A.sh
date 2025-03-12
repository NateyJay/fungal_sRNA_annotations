#!/bin/bash

mkdir ../annotations/Blgra.PRJNA479878
cd ../annotations/Blgra.PRJNA479878

echo Blgra.PRJNA479878.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




