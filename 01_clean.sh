#!/bin/bash

rm refined-set/*/*sdf
rm refined-set/*/*_pocket.pdb

list=$(ls -d refined-set/????)
index=refined-set/index/INDEX_refined_set.2019

# PDB Download
lroot="https://www.rcsb.org/pdb/download/"
lopt="instanceType=first&excludeUnobserved=false&includeHydrogens=false"

for dir in ${list}
do
    pdbid=$(basename ${dir})

    liginfo=$(grep "^${pdbid}" ${index} | awk '{print $7}')
    
    lig=$(echo ${liginfo} | sed "s/(//g" | sed "s/)//g")

    len=${#lig}

    # Upper case PDB name
    # This avoids problems with downloadLigandFiles
    PDB=$(echo ${pdbid} | awk '{print toupper($1)}')

    if [ ${len} -ne 3 ] # Remove peptides, ...
    then
        echo -n "Removing PDBID ${PDB} (${lig})..."

        rm -r ${dir}
        
        echo "done"
    else
        echo -n "Downloading LIG ${lig} for PDBID ${PDB}..."

        llig="ligandIdList=${lig}"
        lpdb="structIdList=${PDB}"

        wget -q "${lroot}/downloadLigandFiles.do?${llig}&${lpdb}&${lopt}" -O ${dir}/${pdbid}_ligand.sdf

        echo "done"
    fi

done


