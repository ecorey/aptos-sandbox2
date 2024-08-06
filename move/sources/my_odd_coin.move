module named_addr::my_odd_coin {


    use std::signer;
    use named_addr::basic_coin;

    struct MyOddCoin has drop {}

    const ENOT_ODD: u64 = 0;

    public fun setup_and_mint(account: &signer, amount: u64) {
        basic_coin::publish_balance<MyOddCoin>(account);
        basic_coin::mint<MyOddCoin>(signer::address_of(account), amount, MyOddCoin{});
    }

    public fun transfer(from: &signer, to: address, amount: u64) {
        assert!(amount % 2 == 1, ENOT_ODD);
        basic_coin::transfer<MyOddCoin>(from, to, amount, MyOddCoin{});
    }







}