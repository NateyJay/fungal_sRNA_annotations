#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA282111
cd ../annotations/Rhsol.PRJNA282111

echo Rhsol.PRJNA282111.F


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n F -a tradeoff_F


echo "
"




