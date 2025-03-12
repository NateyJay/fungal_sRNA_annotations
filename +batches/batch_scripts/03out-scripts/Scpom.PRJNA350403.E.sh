#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350403
cd ../annotations/Scpom.PRJNA350403

echo Scpom.PRJNA350403.E


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n E -a tradeoff_E


echo "
"




