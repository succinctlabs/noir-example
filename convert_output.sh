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

# Write to output.json
echo "{\"output\": \"$output\"}" > output.json
