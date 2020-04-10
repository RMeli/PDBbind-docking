#!/bin/bash

n_cpus=6

list=$(ls -d docking/????)

rmsd(){
    dir=${1}
    
    system=$(basename ${dir})
    
    ref=${dir}/${system}_ligand.sdf
    docking=${dir}/${system}_dock.sdf
    
    python -m spyrmsd.spyrmsd ${ref} ${docking} > ${dir}/spyrmsd.dat
    python -m spyrmsd.spyrmsd ${ref} ${docking} -m > ${dir}/spyrmsd-min.dat
}

export -f rmsd

parallel -j ${n_cpus} rmsd ::: ${list}
