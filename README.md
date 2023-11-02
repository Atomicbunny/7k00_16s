# 7k00_16s
16s subunit of the bacterial ribosome

Before anything, find and identify non standard residues and ensure you know where they are in the molecule

 Instructions for use of charm-gui for development of namd compatible pdb and psf files:

 1: download 7k00pdbbundle1edit.pdb (or whatever pdb file you wish), 7k00pbdbundle contains all data concerning the 16s subunit of the bacterial ribosome.
 
 2:(if you have an account, just sign in) create an account on charm-gui, set your password.
 
 3: select PDB reader and manipulator from the menu
 
 4: upload the pdb file that you want to convert
 
 5:Click the arrow captioned next step at the bottom right of the screen, it may take a long time for large molecules (15-30 min)
 
 6:Once loading is finished, it will automatically process segments out of the input, and give you options to modify the settings it generated. Click the next step arrow once you are satisfied. (I used the settings it generated for convenience)
 
 7: You are given several options, but we are interested in one near the bottom titled Non-standard amino acid / RNA substitution, check the box next to it.
 
 8: By referencing the heteroatoms in your pdb file, enter every residue id for each non-standard/engineered residue in the substitution section, and use its 3 letter typing as provided by the charm-gui program above in the section titled Renaming Engineered Residues. Charm-Gui offers both graphical and text entry for the non-standard residues in the form of the select image and preceding drop down menu respectively.
 
 9:You must select the segment first (which is why you need to have the pdb file ready of non standard resid's listed) and then select the residue id. Continue adding lines for residue substitution until you have added all non standard residues (even repeats of the same type of residue) to the list for substitution. 

 9:This should complete after only a few minutes maximum. It will output a namd compatible pdb and psf file titled "step1_pdbreader" that can be downloaded as part of a tgz file along with the other files related to it.

 10. after this, I uploaded these files to the deac cluster and ran the solvate.pgn script but modified for the file names I had given the pdb and psf files.

 11. these files should be viewable with vmd
