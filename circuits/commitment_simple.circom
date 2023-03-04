pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/poseidon.circom";

/*
    A depositor posts a commitment when they enter the pool. When the withdraw, they must prove knowledge of the secret
    they used to construct the commitment.

    This commitment scheme allows for commitment re-use, because the nullifier is derived from the secret and the
    position of the commitment in the tree.
*/

template CommitmentNullifierHasher() {
    signal input secret; // secret is a random value that only the depositor knows
    signal input path; // path is the merkle tree index of the commitment in the deposit tree

    signal output commitment; // to be checked for inclusion in the deposit tree
    signal output nullifier; // unique to the deposit position. prevents a double spend

    // compute the commitment
    component commitmentHasher = Poseidon(1);
    commitmentHasher.inputs[0] <== secret;
    commitment <== commitmentHasher.out;

    // compute the nullifier
    component nullifierHasher = Poseidon(3);
    nullifierHasher.inputs[0] <== secret;
    nullifierHasher.inputs[1] <== 1;
    nullifierHasher.inputs[2] <== path;
    nullifier <== nullifierHasher.out;
}
