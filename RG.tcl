#/usr/bin/wish
#Run gofr function of a large dcd file

lappend auto_path "/deac/csc/choGrp/turkm23/7k00_16sSim/dyna"

package require bigdcd 2.0

proc myRgyr { frame } {
global sel 
set output [open "RG.dat" a+]
puts "$frame: [measure rgyr $sel ]"
puts $output [format "%f" [measure rgyr $sel ]]
close $output
}


#Radius of Gyration measurement script, a one and done script
set mol [mol load psf 7k0016s2_tmao_wbiSHRT.psf]

set sel [atomselect $mol "nucleic"]

mol addfile 7k0016s2_tmao_wbiSHRT.pdb waitfor all

bigdcd myRgyr auto 7k00_100ns_solvremvd.dcd

bigdcd_wait

exit