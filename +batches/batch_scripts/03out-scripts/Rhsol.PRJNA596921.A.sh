#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA596921
cd ../annotations/Rhsol.PRJNA596921

echo Rhsol.PRJNA596921.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




