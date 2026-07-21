## starting docker daemon with colima
colima start
docker ps -a

## pulling earlgrey image
## *Note, this image is not the same as listed on the github.
docker pull tobybaril/earlgrey:v6.3.1-nodfam

## running
docker run -it -v 'pwd':/data/ tobybaril/earlgrey:v6.3.1-nodfam

cd /usr/local/share/RepeatMasker/Libraries/famdb/

## configuring dfam39 (configure_dfam39.sh)

curl -o 'dfam39_full.0.h5.gz' 'https://dfam.org/releases/current/families/FamDB/dfam39_full.0.h5.gz'
# curl -o 'dfam39_full.5.h5.gz' 'https://dfam.org/releases/current/families/FamDB/dfam39_full.5.h5.gz'
# curl -o 'dfam39_full.6.h5.gz' 'https://dfam.org/releases/current/families/FamDB/dfam39_full.6.h5.gz'
curl -o 'dfam39_full.16.h5.gz' 'https://dfam.org/releases/current/families/FamDB/dfam39_full.16.h5.gz'

gunzip *.gz

cd /usr/local/share/RepeatMasker/
mv /usr/local/share/RepeatMasker/Libraries/famdb/min_init.0.h5 /usr/local/share/RepeatMasker/Libraries/famdb/min_init.0.h5.bak
perl ./configure -libdir /usr/local/share/RepeatMasker/Libraries/ -trf_prgm /usr/local/bin/trf -rmblast_dir /usr/local/bin -hmmer_dir /usr/local/bin -abblast_dir /usr/local/bin -crossmatch_dir /usr/local/bin -default_search_engine rmblast












