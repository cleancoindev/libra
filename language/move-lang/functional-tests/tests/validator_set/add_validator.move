// Add simple validator to LibraSystem's validator set.

//! account: bob, 1000000, 0, validator

//! sender: bob
script {
use 0x1::LibraSystem;
use 0x1::ValidatorConfig;
fun main() {
    // test bob is a validator
    assert(ValidatorConfig::is_valid({{bob}}) == true, 98);
    assert(LibraSystem::is_validator({{bob}}) == true, 98);
}
}

// check: EXECUTED

//! new-transaction
//! sender: association
script {
use 0x1::LBR::LBR;
use 0x1::LibraAccount;
fun main(creator: &signer) {
    LibraAccount::create_validator_account<LBR>(
        creator, 0xAA, x"00000000000000000000000000000000"
    );
}
}

// check: EXECUTED

// TODO(valerini): enable the following test once the sender format is supported
// //! new-transaction
// //! sender: 0xAA
// script {
// use 0x1::ValidatorConfig;
// use 0x1::ValidatorOperatorConfig;
// fun main() {
//     ValidatorConfig::set_config(0xAA, x"10", x"20", x"30", x"40", x"50", x"60");
//     let config = ValidatorConfig::get_config(0xAA);
//     let consensus_pk = ValidatorConfig::get_consensus_pubkey(&config);
//     let expected_pk = x"10";
//     assert(consensus_pk == &expected_pk, 98);
//
//     // add itself as a validator
//     let validator_size = LibraSystem::validator_set_size();
//     assert(validator_size == 1, 99);
//     LibraSystem::add_validator(0xAA);
//    validator_size = LibraSystem::validator_set_size();
//     assert(validator_size == 2, 99);
// }
// }
//
// // check: EXECUTED
// // check: NewEpochEvent
