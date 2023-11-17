#!/bin/bash

# File names
json_file="input.json"
toml_file="Prover.toml"

# Read input from JSON file
input_value=$(jq -r '.input' "$json_file")

# Check if input_value starts with "0x" and remove it
[[ $input_value =~ ^0x ]] && input_value=${input_value:2}

# Convert input to array of decimal bytes
input_bytes=()
for (( i=0; i<${#input_value}; i+=2 )); do
    hex_byte="${input_value:$i:2}"
    decimal_byte=$((16#${hex_byte}))  # Convert from hex to decimal
    input_bytes+=("$decimal_byte")
done

# Write to TOML file
echo "input_bytes = [" > "$toml_file"
for byte in "${input_bytes[@]}"; do
    echo "\"$byte\"," >> "$toml_file"
done
echo "]" >> "$toml_file"