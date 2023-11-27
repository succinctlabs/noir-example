use dep::std::hash::sha256;
use dep::std::println;

fn main(input_bytes: [u8; 32])-> pub (Field, Field) {
    let input_hash = sha256(input_bytes);
    println(input_hash);    
    (input_hash[0] as Field, input_hash[1] as Field)
}

#[test]
fn test_main() {
    // main(1, 2);

    // Uncomment to make test fail
    // main(1, 1);
}
