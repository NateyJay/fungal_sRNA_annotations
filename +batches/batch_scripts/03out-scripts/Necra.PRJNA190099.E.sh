#!/bin/bash

mkdir ../annotations/Necra.PRJNA190099
cd ../annotations/Necra.PRJNA190099

echo Necra.PRJNA190099.E


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n E -a tradeoff_E


echo "
"




