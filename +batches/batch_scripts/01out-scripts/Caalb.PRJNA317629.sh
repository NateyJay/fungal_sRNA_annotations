#!/bin/bash

mkdir ../annotations/Caalb.PRJNA317629
cd ../annotations/Caalb.PRJNA317629

echo Caalb.PRJNA317629


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3344695 SRR3344696 SRR3344726 SRR3344725 SRR3344680 SRR3344679 SRR3344712 SRR3344711 SRR3344688 SRR3344687 SRR3344718 SRR3344717 SRR3344704 SRR3344703 SRR3344672 SRR3344671 \
--conditions SRR3344695:C SRR3344696:C SRR3344726:C SRR3344725:C SRR3344680:C SRR3344679:C SRR3344712:C SRR3344711:C SRR3344688:D SRR3344687:D SRR3344718:D SRR3344717:D SRR3344704:D SRR3344703:D SRR3344672:D SRR3344671:D \
--genome_file ../../Genomes/Caalb.GCF_000182965.3_ASM18296v3_genomic.fa

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


