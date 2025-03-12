#!/bin/bash

mkdir ../annotations/Labic.PRJNA481323
cd ../annotations/Labic.PRJNA481323

echo Labic.PRJNA481323.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




