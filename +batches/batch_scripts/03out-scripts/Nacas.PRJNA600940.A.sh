#!/bin/bash

mkdir ../annotations/Nacas.PRJNA600940
cd ../annotations/Nacas.PRJNA600940

echo Nacas.PRJNA600940.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




