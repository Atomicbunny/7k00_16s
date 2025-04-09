set mol [mol load psf 7k0016s2_tmao_wbiSHRT.psf]
#MA6 PSU 4OC 2MG UR3 5MC G7M Uncomment this and select one to make variants for each nucleotide

mol addfile 7k0016s2_tmao_wbiSHRT.pdb waitfor all
mol addfile 7k00_100ns_solvremvd.dcd first 0 step 100 waitfor all 

# selection
set selmode "2MG"
set sel [atomselect $mol "chain A and resname $selmode"]
set protein [atomselect $mol "nucleic"]
set n [molinfo $mol get numframes]
set output [open "SASA_$selmode.dat" w]
# sasa calculation loop
for {set i 0} {$i < $n} {incr i} {
	molinfo $mol set frame $i
	set sasa [measure sasa 1.4 $protein -restrict $sel]
	puts "\t \t progress: $i/$n"
	puts $output "$sasa"
}
puts "\t \t progress: $n/$n"
puts "Done."	
puts "output file: SASA_$selmode.dat"
close $output


