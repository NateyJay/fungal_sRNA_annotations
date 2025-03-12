#!/bin/bash

mkdir ../annotations/Scpom.PRJNA168300
cd ../annotations/Scpom.PRJNA168300

echo Scpom.PRJNA168300.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




