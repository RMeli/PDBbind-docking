#!/bin/bash

n_cpus=6

list=$(ls -d docking/????)

export obrms=${HOME}/software/openbabel/bin/obrms

rmsd(){
    dir=${1}
    
    system=$(basename ${dir})
    
    ref=${dir}/${system}_ligand.sdf
    docking=${dir}/${system}_dock.sdf
    
    ${obrms} ${docking} ${ref} | awk '{print $3}' > ${dir}/obrms.dat
    ${obrms} ${docking} ${ref} -m | awk '{print $3}' > ${dir}/obrms-min.dat
}

export -f rmsd

parallel -j ${n_cpus} rmsd ::: ${list}
