#!/bin/bash

if [ -f "./ptau/powersOfTau28_hez_final_14.ptau" ]; then
    echo powersOfTau28_hez_final_$TAU.ptau found!
else
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_14.ptau \
        -O ./build/powersOfTau28_hez_final_14.ptau
fi
