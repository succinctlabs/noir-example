#!/bin/bash

# Read input from STDIN
read -r input

# Remove the brackets and split the input into an array
IFS=', ' read -r -a array <<< "${input//[\[\]]/}"

# Concatenate the values without '0x'
output=""
for i in "${array[@]}"
do
    output+="${i//0x/}"
done

# Prepend '0x' to the final output
output="0x$output"

# Read the first line from proofs/circuits.proof
proof=$(head -n 1 proofs/circuits.proof)

# Prepend '0x' to the proof
proof="0x$proof"

# Write to output.json in the specified format
echo -e "{\n\t\"type\": \"res_bytes\",\n\t\"data\": {\n\t\t\"output\": \"$output\",\n\t\t\"proof\": \"$proof\"\n\t}\n}" > output.json
