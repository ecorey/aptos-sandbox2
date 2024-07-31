module 0xCAFE::basic_coin {


    #[test_only]
    use std::signer;


    struct Coin has key {

        value: u64,

    }


    public fun mint(account: &signer, value: u64) {
        move_to(account, Coin {value})
    }



    // TEST
    #[test(account = 0xCAFE)]
    fun test_mint_10(account: &signer) aquires Coin {

        let addr = signer::address_of(account);
        
        mint(account, 10);
        
        assert!(borrow_global<Coin>(addr).value = 10, 0);
    }



}