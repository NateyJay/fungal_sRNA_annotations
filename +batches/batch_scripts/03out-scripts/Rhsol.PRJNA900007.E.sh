#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA900007
cd ../annotations/Rhsol.PRJNA900007

echo Rhsol.PRJNA900007.E


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n E -a tradeoff_E


echo "
"




