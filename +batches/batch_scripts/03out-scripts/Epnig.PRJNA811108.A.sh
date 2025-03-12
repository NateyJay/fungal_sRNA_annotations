#!/bin/bash

mkdir ../annotations/Epnig.PRJNA811108
cd ../annotations/Epnig.PRJNA811108

echo Epnig.PRJNA811108.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




