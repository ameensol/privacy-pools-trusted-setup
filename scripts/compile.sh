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