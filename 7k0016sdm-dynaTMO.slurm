#!/bin/bash
#SBATCH --job-name="16S_100ns1"       # Name that appears in queue
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
SIMID=7k00_1


for ((i=103; i<=202; i++))
do
    prev=`expr $i - 1`
    # go to home directory
    cd $HOMEDIR

    # create md simulation NAMD script
    ./7k0016S_TMODYNA_gen_scripts.sh ${i}

    # copy files for running simulations over to scratch directory
    cp par_all36m_prot.prm par_all36_na.prm par_all36_carb.prm par_all36_lipid.prm spd.prm par_all36_cgenffedit.prm toppar_water_ions_namd.str toppar_all36_na_rna_modified.str 7k0016s2_tmao_wbi.psf 7k0016s2_tmao_wbi.pdb 7k0016S_TMO_wbi_${i}e.conf 7k0016S_TMO_wbi_${prev}e.restart.coor 7k0016S_TMO_wbi_${prev}e.restart.vel 7k0016S_TMO_wbi_${prev}e.restart.xsc 7k0016S_TMO_wbi_${prev}e.xsc $SCRATCHDIR 
	 
    # go to scratch directory
    cd $SCRATCHDIR

    # run NAMD scripts 
    namd3 +auto-provision $SCRATCHDIR/7k0016S_TMO_wbi_${i}e.conf > $SCRATCHDIR/7k0016S_TMO_wbi_${i}e.out

    # copy everything over
    cp 7k0016S_TMO_wbi_${i}e.out 7k0016S_TMO_wbi_${i}e.restart.coor 7k0016S_TMO_wbi_${i}e.restart.vel 7k0016S_TMO_wbi_${i}e.restart.xsc 7k0016S_TMO_wbi_${i}e.coor 7k0016S_TMO_wbi_${i}e.vel 7k0016S_TMO_wbi_${i}e.xsc 7k0016S_TMO_wbi_${i}e.dcd $HOMEDIR

    # go back home
  cd $HOMEDIR
done

# delete scratch directory and its contents
rm -rf $SCRATCHDIR

