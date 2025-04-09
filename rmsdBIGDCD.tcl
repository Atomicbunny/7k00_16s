#/usr/bin/wish
#Run rmsf function of a large dcd file


lappend auto_path "/deac/csc/choGrp/turkm23/7k00_16sSim/dyna"

package require bigdcd 2.0

proc myrmsd { frame } {
global ref sel all
$all move [measure fit $sel $ref]
set fout [open "rmsd.dat" a+]
puts "$frame: [measure rmsd $sel $ref]"
puts $fout [format "%f" [measure rmsd $sel $ref]]
close $fout
}

set mol [mol new 7k0016s2_tmao_wbiSHRT.psf waitfor all]

set all [atomselect $mol all]

set ref [atomselect $mol nucleic frame 0]

set sel [atomselect $mol nucleic]

mol addfile 7k0016s2_tmao_wbiSHRT.pdb type pdb waitfor all

bigdcd myrmsd auto 7k00_100ns_solvremvd.dcd

bigdcd_wait


exit
