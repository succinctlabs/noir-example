#!/bin/bash

# Define the file path
FILE_PATH="./circuits/contract/circuits/plonk_vk.sol"

# Solidity code to append
CODE='
interface IFunctionVerifier {
    function verify(bytes32 _inputHash, bytes32 _outputHash, bytes memory _proof) external returns (bool);

    function verificationKeyHash() external pure returns (bytes32);
}

contract FunctionVerifier is IFunctionVerifier, UltraVerifier {
    function verify(bytes32 _inputHash, bytes32 _outputHash, bytes memory _proof) external returns (bool) {
        bytes32[] memory input = new bytes32[](2);
        input[0] = bytes32(uint256(_inputHash) & ((1 << 253) - 1));
        input[1] = bytes32(uint256(_outputHash) & ((1 << 253) - 1));

        return this.verify(_proof, input);
    }

    function verificationKeyHash() external pure returns (bytes32) {
        return keccak256(abi.encode(UltraVerificationKey.verificationKeyHash()));
    }
}
'

# Append the code to the file
echo "$CODE" >> "$FILE_PATH"
