#!/bin/bash

mkdir ../annotations/Nacas.PRJNA354404
cd ../annotations/Nacas.PRJNA354404

echo Nacas.PRJNA354404.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




