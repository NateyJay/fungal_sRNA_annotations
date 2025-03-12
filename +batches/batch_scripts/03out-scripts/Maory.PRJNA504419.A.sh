#!/bin/bash

mkdir ../annotations/Maory.PRJNA504419
cd ../annotations/Maory.PRJNA504419

echo Maory.PRJNA504419.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




