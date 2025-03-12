#!/bin/bash

mkdir ../annotations/Fubra.PRJNA510758
cd ../annotations/Fubra.PRJNA510758

echo Fubra.PRJNA510758.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




