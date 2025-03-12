#!/bin/bash

mkdir ../annotations/Scscl.PRJNA140539
cd ../annotations/Scscl.PRJNA140539

echo Scscl.PRJNA140539.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




