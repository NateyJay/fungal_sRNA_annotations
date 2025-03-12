#!/bin/bash

mkdir ../annotations/Alalt.PRJNA475703
cd ../annotations/Alalt.PRJNA475703

echo Alalt.PRJNA475703.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




