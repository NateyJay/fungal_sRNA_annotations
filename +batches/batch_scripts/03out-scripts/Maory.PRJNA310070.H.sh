#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070.H


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n H -a tradeoff_H


echo "
"




