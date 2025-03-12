#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827.E


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n E -a tradeoff_E


echo "
"




