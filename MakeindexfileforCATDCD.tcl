set mol [mol load psf 7k0016s2_tmao_wbi.psf]
mol addfile 7k0016s2_tmao_wbi.pdb
set a [atomselect $mol "chain A W"]
$a writepsf 7k0016s2_tmao_wbiSHRT2.psf
$a writepdb 7k0016s2_tmao_wbiSHRT2.pdb
set atoms [$a get index]
set out [open "indexfile2.txt" w]
puts $out $atoms
close $out

#./catdcd -s 7k0016s2_tmao_wbi.pdb -o 7k00_100ns_TMOremvd.dcd -otype dcd -i indexfile.txt -dcd 7k0016S_TMO_wbi_[123456789]e.dcd -dcd 7k0016S_TMO_wbi_[123456789][0123456789]e.dcd -dcd 7k0016S_TMO_wbi_10[0123456789]e.dcd -dcd 7k0016S_TMO_wbi_1[123456789][0123456789]e.dcd -dcd 7k0016S_TMO_wbi_200e.dcd -dcd 7k0016S_TMO_wbi_201e.dcd

#./catdcd -s 7k0016s2_tmao_wbi.pdb -o 7k00_100ns_TMOremvd.dcd -otype dcd -i indexfile.txt -dcd -dcd 7k0016S_TMO_wbi_10[23456789]e.dcd -dcd 7k0016S_TMO_wbi_1[123456789][0123456789]e.dcd -dcd 7k0016S_TMO_wbi_200e.dcd -dcd 7k0016S_TMO_wbi_201e.dcd -dcd 7k0016S_TMO_wbi_202e.dcd