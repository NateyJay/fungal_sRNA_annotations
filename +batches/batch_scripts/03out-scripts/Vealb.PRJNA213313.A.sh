#!/bin/bash

mkdir ../annotations/Vealb.PRJNA213313
cd ../annotations/Vealb.PRJNA213313

echo Vealb.PRJNA213313.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




