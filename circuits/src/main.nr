use dep::std::hash::sha256;

fn main(input_bytes: [u8; 100])-> pub [u8; 32] {
    // let input_bytes = [1, 2, 3, 4, 5, 6, 7, 8];
    let input_hash = sha256(input_bytes);
    input_hash
}


#[test]
fn test_main() {
    // main(1, 2);

    // Uncomment to make test fail
    // main(1, 1);
}
