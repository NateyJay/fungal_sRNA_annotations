#!/bin/bash

mkdir ../annotations/Vamal.PRJNA413773
cd ../annotations/Vamal.PRJNA413773

echo Vamal.PRJNA413773.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




