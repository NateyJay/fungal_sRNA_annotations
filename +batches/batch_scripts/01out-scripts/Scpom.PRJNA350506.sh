#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350506
cd ../annotations/Scpom.PRJNA350506

echo Scpom.PRJNA350506


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR4449756 SRR4449757 SRR4449760 SRR4449761 SRR4449764 SRR4449765 SRR4449758 SRR4449759 SRR4449762 SRR4449763 SRR4449766 SRR4449767 \
--conditions SRR4449756:A SRR4449757:A SRR4449760:A SRR4449761:A SRR4449764:A SRR4449765:A SRR4449758:B SRR4449759:B SRR4449762:B SRR4449763:B SRR4449766:B SRR4449767:B \
--genome_file ../../Genomes/Scpom.GCA_000002945.2_ASM294v2_genomic.fa

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


