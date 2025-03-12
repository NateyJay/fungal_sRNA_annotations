#!/bin/bash

mkdir ../annotations/Vapol.PRJNA140091
cd ../annotations/Vapol.PRJNA140091

echo Vapol.PRJNA140091.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




