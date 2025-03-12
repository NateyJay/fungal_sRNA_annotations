#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827.H


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n H -a tradeoff_H


echo "
"




