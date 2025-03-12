#!/bin/bash

mkdir ../annotations/Scscl.PRJNA315516
cd ../annotations/Scscl.PRJNA315516

echo Scscl.PRJNA315516.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




