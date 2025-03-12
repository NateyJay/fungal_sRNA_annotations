#!/bin/bash

mkdir ../annotations/Scpom.PRJNA322455
cd ../annotations/Scpom.PRJNA322455

echo Scpom.PRJNA322455.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




