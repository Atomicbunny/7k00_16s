#/usr/bin/wish
#determine # of waters hydrating phosphate backbone in each frame of RNA of a large dcd file

lappend auto_path "/deac/csc/choGrp/turkm23/7k00_16sSim/dyna"

package require bigdcd 2.0

proc myCon { frame } {
global back sel outfile
set b [llength list{[lindex [measure contacts 3.5 $sel $back] 0]}]
puts $b
puts $outfile "$frame: $b"
}

#Select molecule and trajectory
set mol [mol load pdb 7k0016s2_tmao_wbiSHRT2.pdb]
mol addfile 7k0016s2_tmao_wbiSHRT2.psf

# set up the atom selections                                                                                      
set back [atomselect $mol "type O1P O2P"]
set sel [atomselect $mol "type OH2" ]

# calculate the number of water contacts 
set outfile [open WATERPHOSPHOR_Contacts.dat w] 

bigdcd myCon auto 7k00_100ns_TMOremvd.dcd


bigdcd_wait


#outfile should contain ALL  frames
close $outfile

#exit vmd                                                                                                          
exit
