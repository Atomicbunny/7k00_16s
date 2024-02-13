# _E. coli_ 16S Ribosome 
How to use Charmm-GUI to produce NAMD compatible PDB and PSF files

***Before doing anything, find and identify non-standard residues and ensure you know where they are in the molecule***

For control test of simulation:
Equilibration of 7k00 16s subunit in water box

Original file obtained from RCSB PDB: https://www.rcsb.org/structure/7k00
1. Downloaded "PDB format-like files (.tar.gz) and extracted 7k00pdbbundle1.pdb
2. Selected out Chain A, which corresponds to 16S ribosome.
3. Resulting file is 7k00pdbbundle1edit.pdb.
4. renamed to 

--- Charmm-GUI website: https://charmm-gui.org/ ---

 Instructions for use of CHARMM-GUI for development of NAMD compatible PDB and PSF files:
 
 1:(if you have an account, just sign in) Create an account on CHARMM-GUI and set your password.

 2: Select "input generator" link, then "PDB Reader & Manipulator" link.

 3: Upload the PDB file that you want to convert and select the "Check/Correct PDB Format" button.
 
 4: Click the arrow captioned next step at the bottom right of the screen. (Note: It may take a long time for large molecules, about 15-30 minutes max, avg time about 5 minutes).
 
 5: Once loading is finished, it will automatically process segments out of the input, and give you options to modify the settings it generated. We removed the Paromomycin (PAR) but kept all nucleic acids of  and Spermidine (SPD), Mg(2+) ions, and crystal waters. Click the next step arrow once you are satisfied.

 
 7: You are given several options, but we are interested in one near the bottom titled Non-standard amino acid / RNA substitution, check the box next to it.

 
 8: By referencing the heteroatoms in your pdb file, enter every residue id for each non-standard/engineered residue in the substitution section, and use its 3 letter identification as provided by the Charmm-GUI program above in the section titled Renaming Engineered Residues. Charmm-GUI offers both graphical and text entry for the non-standard residues in the form 
 of the select image and preceding drop down menu respectively.

 
 9: You must select the segment first (which is why you need to have the pdb file ready of non standard resid's listed) and then select the residue id. Continue adding lines for residue substitution until you have added all non standard residues (even repeats of the same type of residue) to the list for substitution. 


 10: This should complete after only a few minutes maximum. It will output a NAMD compatible pdb and psf file titled "step1_pdbreader" that can be downloaded as part of a tgz file along with the other files related to it.


 11. After this, I uploaded these files to the deac cluster and ran the solvate.pgn script but modified for the file names I had given the pdb and psf files. (this is provided in this repository for 7k0016S)


 12. These files should be viewable with vmd, use vmd to quick check for any major issues with your molecule. If nothing is immediately obvious, and no significant errors were logged during generation, then its probably good. 
