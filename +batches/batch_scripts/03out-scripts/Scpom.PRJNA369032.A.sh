#!/bin/bash

mkdir ../annotations/Scpom.PRJNA369032
cd ../annotations/Scpom.PRJNA369032

echo Scpom.PRJNA369032.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




