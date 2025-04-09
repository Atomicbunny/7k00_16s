#/usr/bin/wish
#Run gofr function of a large dcd file

lappend auto_path "/deac/csc/choGrp/turkm23/7k00_16sSim/dyna"

package require bigdcd 2.0

#only g(r) needs to be printed, r itself is the values for all frames and can thus be treated as the same for all
#starts at 0.05 and increments by 0.1 all the way to 10.05

proc mygr { frame } {
global ref sel outfile gr r g all
puts $outfile "$frame: [lindex [measure gofr $sel $ref delta .1 rmax 10 usepbc 1 selupdate 1] 1]"

}

#Select molecule and trajectory
set mol [mol load psf 7k0016s2_tmao_wbiSHRT.psf]

# set up the atom selections                                                                                      
set ref [atomselect $mol "resname GUA URA ADE CYT and name O2'"]
set sel [atomselect $mol "resname TMAO and name O1" ]
mol addfile 7k0016s2_tmao_wbiSHRT.pdb

# calculate g(r)   
set outfile [open ALLSUGARO2'_TMOO1_gofr.dat w]  

bigdcd mygr auto lasthalf.dcd


bigdcd_wait


#outfile should contain ALL  frames
close $outfile

#exit vmd                                                                                                          
exit
