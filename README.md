# Simulation of the _E. coli_ 16S Ribosome with Chemical Modifications
How to use Charmm-GUI to produce NAMD compatible PDB and PSF files

***Before doing anything, find and identify non-standard residues and ensure you know where they are in the molecule***

For control test of simulation:
Equilibration of 7k00 16s rRNA in water box

Original file obtained from RCSB PDB: https://www.rcsb.org/structure/7k00
1. Downloaded "PDB format-like files (.tar.gz) and extracted 7k00pdbbundle1.pdb
2. Selected out Chain A, which corresponds to 16S ribosome.
3. Resulting file is 7k00pdbbundle1edit.pdb.

--- Charmm-GUI website: https://charmm-gui.org/ ---

 Instructions for use of CHARMM-GUI for development of NAMD compatible PDB and PSF files:
 
 1:(if you have an account, just sign in) Create an account on CHARMM-GUI and set your password.

 2: Select "input generator" link, then "PDB Reader & Manipulator" link.

 3: Upload the PDB file that you want to convert and select the "Check/Correct PDB Format" button.
 
 4: Click the arrow captioned next step at the bottom right of the screen. (Note: It may take a long time for large molecules, about 15-30 minutes max, avg time about 5 minutes).
 
 5: Once loading is finished, it will automatically process segments out of the input, and give you options to modify the settings it generated. We removed the Paromomycin (PAR) but kept all nucleic acids , Mg(2+) ions, and crystal waters. Click the next step arrow once you are satisfied.

 
 7: You are given several options, but we are interested in one near the bottom titled Non-standard amino acid / RNA substitution, check the box next to it.

 
 8: By referencing the heteroatoms in your pdb file, enter every residue id for each non-standard/engineered residue in the substitution section, and use its 3 letter identification as provided by the Charmm-GUI program above in the section titled Renaming Engineered Residues. Charmm-GUI offers both graphical and text entry for the non-standard residues in the form 
 of the select image and preceding drop down menu respectively.

 9: You must select the segment first (which is why you need to have the pdb file ready of non standard resid's listed) and then select the residue id. Continue adding lines for residue substitution until you have added all non standard residues (even repeats of the same type of residue) to the list for substitution. 


10: This should complete after only a few minutes maximum. It will output a NAMD compatible pdb and psf file titled "step1_pdbreader" that can be downloaded as part of a tgz file along with the other files related to it.


11: After this, I uploaded these files to the deac cluster and ran the solvate.pgn script but modified for the file names I had given the pdb and psf files. (this is provided in this repository for 7k0016S)


12: These files should be viewable with vmd, use vmd to quick check for any major issues with your molecule. If nothing is immediately obvious, and no significant errors were logged during generation, then its probably good.

13:  run 7k00md-equil.slurm with pdbreader files

14:  check that trajectory generated is acceptable using vmd and analysis tools.


#  Simulation TMAO

---Simulation of 16S rRNA of E.Coli ribosome in 1.00 mol/L TMAO solution ---

*for water box of size used (can be found in 7k0016s2.namd.pdb) , 5781 molecules of TMAO corresonds to 1.00 mol/L TMAO

*crystal waters and ions present in the 16s subunit from original 7k00 pdb were retained.

1: 7k0016s2.namd.pdb is simply a renamed version of pdbreaderedit1.pdb, this was used in the generation of the following pdb files.

2: ran center_prot_origin.tcl to center the molecule around the origin, result is renamed to centered.7k0016s2.namd.pdb. We will use this file to obtain valid TMAO coordinates for a water box and to generate the TMAO water box. Make sure you keep this.

3: Solvate 16s subunit in water box with Na+ and Cl- ions at 0.01 mol/L to neutralize charge. Kept unsolvated file on hand.

4: removed crystal waters from solvated pdb that lacks TMAO, result is renamed to whatever you see fit as this file is just for obtaining valid water coordinates. (You can remove the RNA, ions and crystal waters as all we are interested in are the generated water molecule coordinates, but you don't have to)

5: run gen_tmaomt.sh with first argument "name of solvated centered PDB" and second argument "5781" to produce a file containing a list of all water coordinates (tmao1.dat). You now no longer need the solvated pdb without TMAO.

6: manually make changes to this file (tmao1.dat) , use regex and find to replace all entries /d- with "0 -" to resolve unspaced elements, also remove
 all instances of 1.00 whole word to remove fourth columns. (Do note that this solution is imperfect, however the loss in coordinate precision is small and only affects tmao molecules)

7: run gen_tmaomt2.sh, this will create tmao.pdb, a pseudorandom coordinate pdb file of TMAO molecules.

8: manually realign all entries past residue 1000 of tmao.pdb to eliminate column alignment errors.

9: run setup_with_tmaomt using the unsolvated pdb file, this will generate a pdb with the 16s subunit surrounded by TMAO

10: run solvate_with_tmaomt2 to solvate your new RNA-TMAO. This will create files that will be used in simulation.

11: repeat steps 6-9 twice more to create 3 separate pseudorandom TMAO coordinate sets implemented with the 16s rRNA in a water box.

12: You may get an unusual bond error (should only be one or two), use vmd to identify which atoms are involved in the bond, and remove this bond, the angles, and dihedrals from the psf file. Be sure when editing the psf file to not leave any extra whitespace
at the end of lines and to increment the number of bonds, angles and dihedrals at the start of each section based on how many you removed. Do note that this procedure should only be used to remove bonds that do not reflect the system IE rigid bonds between Mg ions and 
the ribosome.

13: check psf file in vmd, if it loads without errors, it should be good to go. (unusual bond and max bond errors may occur)

14: run minimization/equilibration step in separate directories for each pdb

15: run dynamics in separate directories
