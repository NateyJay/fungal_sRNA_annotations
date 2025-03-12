#!/bin/bash

mkdir ../annotations/Scjap.PRJNA770349
cd ../annotations/Scjap.PRJNA770349

echo Scjap.PRJNA770349.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




