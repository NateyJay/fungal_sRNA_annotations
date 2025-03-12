#!/bin/bash

mkdir ../annotations/Tamar.PRJNA207279
cd ../annotations/Tamar.PRJNA207279

echo Tamar.PRJNA207279.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




