#!/bin/bash
#SBATCH --job-name="16S_requil1"       # Name that appears in queue
#SBATCH --partition=gpu              # Resource group (small/medium/large)
#SBATCH --account=choGrp             # Research group
#SBATCH --nodes=1                    # Number of Nodes
#SBATCH --ntasks-per-node=64         # Number of CPU Cores
#SBATCH --mem=200gb                  # Requested memory
#SBATCH --time=07-00:00:00           # Job duration in DD-HH:MM:SS
#SBATCH --gres=gpu:4		         # Number of GPUs
#SBATCH --constraint=zen4            # Run on zen4 architecture
#SBATCH --mail-user=turkm23@wfu.edu  # Email address to update on Job status
#SBATCH --mail-type=END,FAIL         # Updates to provide mail-user

# Load module files
module use /deac/opt/modulefiles/rocky9-zen4/ /deac/opt/modulefiles/rocky9-noarch/
module load apps/namd/3.0b6

# set home directory
HOMEDIR=/deac/csc/choGrp/turkm23/7k00_16sSim/dyna
# set scratch directory
SCRATCHDIR=/scratch/$SLURM_JOBID
# set simulation ID
SIMID=7k00_Equil1
# go to home directory
cd $HOMEDIR

# copy files for running simulations over to scratch directory
cp toppar_all36_na_rna_modified.str par_all36_lipid.prm par_all36_carb.prm par_all36m_prot.prm par_all36_na.prm spd.prm par_all36_cgenffedit.prm toppar_water_ions_namd.str 7k0016s2_tmao_wbi.psf 7k0016s2_tmao_wbi.pdb 7k0016S_TMO_wbi_1e.conf $SCRATCHDIR                                                                                                                             

# go to scratch directory
cd $SCRATCHDIR

# run NAMD scripts 
namd3 +auto-provision $SCRATCHDIR/7k0016S_TMO_wbi_1e.conf > $SCRATCHDIR/7k0016S_TMO_wbi_1e.out

# copy everything over
cp 7k0016S_TMO_wbi_1e.out 7k0016S_TMO_wbi_1e.restart.coor 7k0016S_TMO_wbi_1e.restart.vel 7k0016S_TMO_wbi_1e.restart.xsc 7k0016S_TMO_wbi_1e.coor 7k0016S_TMO_wbi_1e.vel 7k0016S_TMO_wbi_1e.xsc 7k0016S_TMO_wbi_1e.xst 7k0016S_TMO_wbi_1e.dcd $HOMEDIR

# delete scratch directory and its contents
rm -rf $SCRATCHDIR
