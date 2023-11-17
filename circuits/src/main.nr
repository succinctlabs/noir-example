use dep::std::hash::sha256;
use dep::std::println;

fn main(input_bytes: [u8; 100])-> pub (Field, Field) {
    // let input_bytes = [1, 2, 3, 4, 5, 6, 7, 8];
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
