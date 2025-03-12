#!/bin/bash

mkdir ../annotations/Gasin.PRJNA42807
cd ../annotations/Gasin.PRJNA42807

echo Gasin.PRJNA42807.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




