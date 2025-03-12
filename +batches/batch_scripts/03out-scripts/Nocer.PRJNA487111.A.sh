#!/bin/bash

mkdir ../annotations/Nocer.PRJNA487111
cd ../annotations/Nocer.PRJNA487111

echo Nocer.PRJNA487111.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




