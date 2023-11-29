use dep::std::hash::sha256;
use dep::std::println;

fn main(input_bytes: [u8; 8]) -> pub (Field, Field) {
    let input_hash = sha256(input_bytes);
    let output_bytes = generate_output_bytes(input_bytes);
    println(output_bytes);
    let output_hash = sha256(output_bytes);

    process_hashes(input_hash, output_hash)
}

fn generate_output_bytes(input_bytes: [u8; 8]) -> [u8; 32] {
    let mut power: u32 = 1;
    let mut a: u32 = 0;
    let mut b: u32 = 0;
    for i in 0..4 {
        a += (input_bytes[i] as u32) * power;
        b += (input_bytes[i+4] as u32) * power;
        power *= 2;
    }
    let c: u32 = a + b;
    let output = (c as Field).to_le_bytes(32);
    let mut output_bytes: [u8; 32] = [0; 32];
    for i in 0..32 {
        output_bytes[i] = output[i];
    }
    output_bytes
}

fn process_hashes(input_hash: [u8; 32], output_hash: [u8; 32]) -> (Field, Field) {
    let mut input_hash_el: Field = 0;
    let mut output_hash_el: Field = 0;
    let mut power: Field = 1;

    for i in (0 as u32)..(32 as u32) {
        let input_hash_bits = (input_hash[32-i-1] as Field).to_le_bits(8);
        let output_hash_bits = (output_hash[32-i-1] as Field).to_le_bits(8);

        for j in (0 as u32)..(8 as u32) {
            if i*8 + j < 253 {
                input_hash_el += (input_hash_bits[j] as Field) * power;
                output_hash_el += (output_hash_bits[j] as Field) * power;
            }
            power *= 2;
        }
    }
    
    (input_hash_el, output_hash_el)
}

#[test]
fn test_generate_output_bytes() {
    let input_bytes: [u8; 8] = [0xFA, 0x3D, 0x0A, 0x0C, 0xA7, 0x42, 0x29, 0xDE];
    let expected_output: [u8; 32] = [0xBB, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
    
    let output = generate_output_bytes(input_bytes);

    for i in 0..32 {
        assert(output[i] == expected_output[i], "Output mismatch");
    }
}


#[test]
fn test_process_hashes() {
    let input_bytes: [u8; 8] = [0xFA, 0x3D, 0x0A, 0x0C, 0xA7, 0x42, 0x29, 0xDE];
    let input_hash = sha256(input_bytes);
    let output_bytes = generate_output_bytes(input_bytes);
    let output_hash = sha256(output_bytes);

    let expected_output: ([u8; 32], [u8; 32]) = (input_hash, output_hash);

    let result = process_hashes(input_hash, output_hash);

    println(result.0);
    println(expected_output.0);
    println(result.1);
    println(expected_output.1);

    // assert(result.0 == expected_output.0, "First element of process_hashes result did not match");
    // assert(result.1 == expected_output.1, "Second element of process_hashes result did not match");
}