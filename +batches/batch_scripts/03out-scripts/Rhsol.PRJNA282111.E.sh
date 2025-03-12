#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA282111
cd ../annotations/Rhsol.PRJNA282111

echo Rhsol.PRJNA282111.E


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n E -a tradeoff_E


echo "
"




