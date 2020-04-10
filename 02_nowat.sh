#!/bin/bash

list=$(ls -d refined-set/????)

n_cpus=10

nowat(){
    dir=${1}

    system=$(basename ${dir})

    # Input
    recname=${dir}/${system}_protein.pdb
    recwatname=${dir}/${system}_protein-wat.pdb

    mv ${recname} ${recwatname}

    grep -v "HOH" ${recwatname} > ${recname}
}

export -f nowat

parallel -j ${n_cpus} nowat ::: ${list}
