#!/bin/bash

TARGET="withdraw_from_subset_simple"

if [ ! -f "./build/${TARGET}.r1cs" ] \
    || [ ! -f "./build/${TARGET}_js/${TARGET}.wasm" ] \
    || [ ! -f "./build/${TARGET}.sym" ]
then
    circom ./circuits/$TARGET.circom \
		-o=./build --r1cs --sym --wasm
    echo $TARGET circuit compiled!
else
    echo $TARGET circuit already compiled!
fi

if [ -f "./build/powersOfTau28_hez_final_14.ptau" ]; then
    echo powersOfTau28_hez_final_$TAU.ptau found!
else
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_14.ptau \
        -O ./build/powersOfTau28_hez_final_14.ptau
fi

if [ ! -f "./build/${TARGET}_0000.zkey" ]
then
    echo generating zkp proving and verifying keys!
    snarkjs g16s \
		./build/$TARGET.r1cs \
		./powers_of_tau/powersOfTau28_hez_final_$TAU.ptau \
		./build/${TARGET}_0000.zkey -v
    echo $TARGET groth16 setup complete!
else
    echo $TARGET groth16 setup already complete!
fi
