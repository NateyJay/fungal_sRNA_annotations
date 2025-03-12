#!/bin/bash

mkdir ../annotations/Aupul.PRJNA892012
cd ../annotations/Aupul.PRJNA892012

echo Aupul.PRJNA892012.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




