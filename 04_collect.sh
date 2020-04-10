#!/bin/bash

export root=docking

list=$(ls -d refined-set/????)

mkdir -p ${root}

n_cpus=6

collect(){
    dir=${1}

    system=$(basename ${dir})

    outdir=${root}/${system}

    mkdir -p ${outdir}

    cp ${dir}/*.sdf ${outdir}

}

export -f collect

parallel -j ${n_cpus} collect ::: ${list}
