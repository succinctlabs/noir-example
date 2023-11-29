#!/bin/bash

# File names
json_file="input.json"
toml_file="Prover.toml"

# Read input from JSON file
input_value=$(jq -r '.data.input' "$json_file")

# Check for null or empty input
if [[ -z $input_value || $input_value == "null" ]]; then
    echo "Error: Invalid input in JSON file"
    exit 1
fi

# Check if input_value starts with "0x" and remove it
[[ $input_value =~ ^0x ]] && input_value=${input_value:2}

# Keep only the last 16 characters (last 8 bytes in hex)
input_value=${input_value: -16}

# Print the modified input_value
echo "Processed input value: $input_value"

# Convert input to array of decimal bytes
input_bytes=()
for (( i=0; i<${#input_value}; i+=2 )); do
    hex_byte=${input_value:$i:2}

    # Check if hex_byte contains only hexadecimal characters
    if ! [[ $hex_byte =~ ^[0-9a-fA-F]+$ ]]; then
        echo "Error: Invalid hexadecimal number '$hex_byte'"
        exit 1
    fi

    # Convert from hex to decimal
    decimal_byte=$(printf "%d" "0x$hex_byte")
    input_bytes+=("$decimal_byte")
done

# Write to TOML file
echo "input_bytes = [" > "$toml_file"
for byte in "${input_bytes[@]}"; do
    echo "\"$byte\"," >> "$toml_file"
done
echo "]" >> "$toml_file"
