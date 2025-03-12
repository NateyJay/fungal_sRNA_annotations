#!/bin/bash

mkdir ../annotations/Scscl.PRJNA379694
cd ../annotations/Scscl.PRJNA379694

echo Scscl.PRJNA379694.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




