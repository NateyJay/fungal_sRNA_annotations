#!/bin/bash

mkdir ../annotations/Nacas.PRJNA530565
cd ../annotations/Nacas.PRJNA530565

echo Nacas.PRJNA530565.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




