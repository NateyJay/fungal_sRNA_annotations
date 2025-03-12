#!/bin/bash

mkdir ../annotations/Nocer.PRJNA487111
cd ../annotations/Nocer.PRJNA487111

echo Nocer.PRJNA487111.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




