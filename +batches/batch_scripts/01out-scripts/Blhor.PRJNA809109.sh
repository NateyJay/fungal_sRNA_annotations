#!/bin/bash

mkdir ../annotations/Blhor.PRJNA809109
cd ../annotations/Blhor.PRJNA809109

echo Blhor.PRJNA809109


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR18094628 SRR18094629 SRR18094630 SRR18094632 SRR18094633 SRR18094631 SRR18094644 SRR18094643 SRR18094634 SRR18094637 SRR18094636 SRR18094635 \
--conditions SRR18094628:A SRR18094629:A SRR18094630:A SRR18094632:B SRR18094633:B SRR18094631:B SRR18094644:C SRR18094643:C SRR18094634:C SRR18094637:D SRR18094636:D SRR18094635:D \
--genome_file ../../Genomes/Blhor.GCA_900239735.1_BGH_DH14_v4_genomic.fa

echo "
downloading..."
yasma.py download -o .

echo "
finding adapters..."
yasma.py adapter -o .

echo "
trimming..."
yasma.py trim -o . --cores 28

echo "
aligning..."
yasma.py align -o . --cores 28


