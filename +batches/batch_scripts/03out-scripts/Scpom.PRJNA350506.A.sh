#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350506
cd ../annotations/Scpom.PRJNA350506

echo Scpom.PRJNA350506.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




