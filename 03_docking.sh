#!/bin/bash

export smina=$HOME/Documents/git/smina-fork/build/linux/release/smina

list=$(ls -d refined-set/????)

n=4

docking(){
    dir=${1}

    system=$(basename ${dir})
    dataset=$(basename $(dirname ${dir}))

    # Ligand and receptor
    ligand=${dir}/${system}_ligand.sdf
    receptor=${dir}/${system}_protein.pdb

    ${smina} -r ${receptor} -l ${ligand} \
	--autobox_ligand ${ligand} \
	--num_modes 10 --cpu 2 \
    --out ${dir}/${system}_dock.sdf \
    2>&1 | tee ${dir}/smina.log
}

export -f docking

parallel -j ${n} docking ::: ${list}
