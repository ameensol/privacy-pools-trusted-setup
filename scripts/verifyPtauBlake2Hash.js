const path = require('path');
const fs = require('fs');
const blake2 = require('blake2');

const expectedHash = 'eeefbcf7c3803b523c94112023c7ff89558f9b8e0cf5d6cdcba3ade60f168af4a181c9c21774b94fbae6c90411995f7d854d02ebd93fb66043dbb06f17a831c1'

const main = async () => {
	    const ptau = fs.readFileSync(path.resolve(__dirname, '..', 'ptau', 'powersOfTau28_hez_final_14.ptau'))
	    const hasher = blake2.createHash('blake2b');
	    hasher.update(ptau);
			const computedHash = hasher.digest("hex")

	    console.log("file hash: ", computedHash);
			console.log("expected hash: ", expectedHash)
			console.log("hashes match: ", computedHash === expectedHash)
			console.log("You can verify that this is the correct expected hash by visitng the snarkjs repository and comparing against the table of ptau files!")
			console.log("https://github.com/iden3/snarkjs#7-prepare-phase-2")
}

main().then(()=>process.exit()).catch(err => {
	    console.error(err.message);
	    process.exit(1);
});
