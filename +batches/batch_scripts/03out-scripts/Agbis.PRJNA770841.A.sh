#!/bin/bash

mkdir ../annotations/Agbis.PRJNA770841
cd ../annotations/Agbis.PRJNA770841

echo Agbis.PRJNA770841.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




