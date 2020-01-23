#!/bin/bash
#Use highmem te reserve a whole node

#$ -l highp,h_rt=12:00:00,h_data=5G
#$ -pe shared 4
#$ -N SSJ_BWA
#$ -cwd
#$ -m bea
#$ -o /u/flashscratch/a/acw414/SSJ/log/SSJ_BWA.out
#$ -e /u/flashscratch/a/acw414/SSJ/log/SSJ_BWA.err
#$ -M acw414


# load paths and programs
export SEQ=/u/home/a/acw414/project-rwayne/step1/data
export BAM=/u/home/a/acw414/project-rwayne/step1/scripts
export REF=/u/home/a/acw414/project-rwayne/step1/canfam31/canfam31.fa
export PICARD=/u/local/apps/picard-tools/current
export BWAREF=/u/home/a/acw414/project-rwayne/step1/canfam31/canfam31

echo "done exportng paths"

# load your modules:
. /u/local/Modules/default/init/modules.sh
module load bwa
module load picard_tools
module load java/1.8.0_77
module load bowtie2

echo "loaded modules"

#align_fn () {
#	echo "***** Beginning alignment of $1 *****"
#	
#	bwa mem -p -M -t 1 ${REF} ${SEQ}/${1}val_1.fq.gz ${SEQ}/${1}val_2.fq.gz > ${BAM}/${1}_bwamem.sam
#	
#	echo "***** Alignment of $1 complete *****"
#		
#	echo "***** $1 processing complete *****"
#}

#align_fn Bush-dog_R0902_

bowtie_fn () {
	bowtie2 -q --phred33 -p4 --very-sensitive-local -X 3200 -x ${BWAREF} -1 ${SEQ}/${1}*val_1.fq.gz -2 ${SEQ}/${1}*val_2.fq.gz -S ${BAM}/${1}_bwt2_3200.sam 
}

bowtie_fn Bush-dog_R0902_
