#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA407898
cd ../annotations/Fuoxy.PRJNA407898

echo Fuoxy.PRJNA407898.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




