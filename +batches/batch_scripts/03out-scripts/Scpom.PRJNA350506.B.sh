#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350506
cd ../annotations/Scpom.PRJNA350506

echo Scpom.PRJNA350506.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




