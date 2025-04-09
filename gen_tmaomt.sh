#!/bin/bash
# Generates a set of TMAO coordinates from the randomly picked water molecules in a PDB file.
# WARNING: Check to make sure that the number of TMAO molecules match the number you expect. (random number generator can pick duplicates)

# check command line arguments
if test $# -ne 1; then
   echo "Usage:  gen_tmao.sh PDBFILE";
   exit;
fi

grep 'OH2'  $1 | cut -dW -f2 | awk '{ print $2, $3, $4 }' > tmao1.dat

rm -f tmao2.dat tmao3.dat

