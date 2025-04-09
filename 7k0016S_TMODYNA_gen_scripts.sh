#!/bin/bash

# check command line arguments
if test $# -ne 1; then
   echo "Usage:  gen_scripts.sh RUNNUM";
   exit;
fi

old=`expr $1 - 1`

cat 7k0016sdynaTMO.temp  | sed "s/NEW/$1/g" | sed "s/OLD/$old/g" > 7k0016S_TMO_wbi_$1e.conf
