#!/bin/bash

rm -f tmao2.dat tmao3.dat tmao4.sh tmao.pdb

shuf -i 1-293537 -n $1 >> tmao2.dat

wc tmao2.dat

for i in `cat tmao2.dat`
do
    sed -n "${i}p" < tmao1.dat >> tmao3.dat
done

awk '{ print "./gen_tmao.pl -n ", NR, " -x ", $1, " -y ", $2, " -z ", $3 }' tmao3.dat > tmao4.sh

bash tmao4.sh > tmao.pdb


