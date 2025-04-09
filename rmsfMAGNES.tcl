set molref  [mol load psf 7k0016s2_tmao_wbiSHRT.psf pdb 7k0016s2_tmao_wbiSHRT.pdb]
mol new 7k0016s2_tmao_wbiSHRT.psf
mol addfile 7k00_100ns_solvremvd.dcd first 0 last 100000 step 100 waitfor 1000 molid 1
mol top 1
mol list

set outfile [open rmsfmagnes.dat w]  
set nf [molinfo top get numframes]  

puts $nf

# "orient" alignment loop
set frame0 [atomselect $molref "type MG"]
for {set i 0} { $i <= $nf } {incr i} {
    set selframe [atomselect top "type MG" frame $i]
    set all [atomselect top all frame $i]
    $all move [measure fit $selframe $frame0]
}


# rmsf loop
set sel [atomselect top "type MG" ]
set i 1
foreach {rmsf} [measure rmsf $sel] {

    puts $outfile "$i $rmsf"
    incr i
}

close $outfile 

exit
