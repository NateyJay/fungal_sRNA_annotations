#!/bin/bash

mkdir ../annotations/Bocin.PRJNA1092616
cd ../annotations/Bocin.PRJNA1092616

echo Bocin.PRJNA1092616.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




