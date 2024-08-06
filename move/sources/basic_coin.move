
// step 8
module named_addr::basic_coin {


    use std:: signer;


    const ENOT_MODULE_OWNER: u64 = 0;
    const EINSUFFICIENT_BALANCE: u64 = 1;
    const EALREADY_HAS_BALANCE: u64 = 2;
    const EALREADY_INITIALIZED: u64 = 3;
    const EEQUAL_ADDR: u64 = 4;


    struct Coin<phantom CoinType> has store {
        value: u64,
    }

    struct Balance<phantom CoinType> has key {
        coin: Coin<CoinType>
    }


    public fun publish_balance<CoinType>(account: &signer) {
        let empty_coin = Coin<CoinType> { value: 0 };
        assert!(!exists<Balance<CoinType>>(signer::address_of(account)), EALREADY_HAS_BALANCE);
        move_to(account, Balance<CoinType> { coin: empty_coin });
    }

    spec publish_balance {
        include Schema_publish<CoinType> {addr: signer::address_of(account), amount: 0};
    }


    spec schema Schema_publish<CoinType>{
        addr: address;
        amount: u64;


        aborts_if exists<Balance<CoinType>>(addr);

        ensures exists<Balance<CoinType>>(addr);

        let post balance_post = global<Balance<CoinType>>(addr).coin.value;

        ensures balance_post == amount;






    }







}

























//step_6
// module named_addr::basic_coin {

//     use std::signer;

//     const ENOT_MODULE_OWNER: u64 = 0;
//     const EINSUFFICIENT_BALANCE: u64 = 1;
//     const EALREADY_HAS_BALANCE: u64 = 2;

//     struct Coin<phantom CoinType> has key, store {
//         value: u64,
//     }

//     struct Balance<phantom CoinType> has key {
//         coin: Coin<CoinType>,
//     }

//     public fun publish_balance<CoinType>(account: &signer) {
//         let empty_coin = Coin<CoinType> { value: 0 };
//         assert!(!exists<Balance<CoinType>>(signer::address_of(account)), EALREADY_HAS_BALANCE);
//         move_to(account, Balance<CoinType> { coin: empty_coin });
//     }

//     public fun mint<CoinType: drop>(mint_addr: address, amount: u64, _witness: CoinType) acquires Balance {
//         deposit(mint_addr, Coin<CoinType> { value: amount });
//     }

//     public fun balance_of<CoinType>(owner: address): u64 acquires Balance {
//         borrow_global<Balance<CoinType>>(owner).coin.value
//     }

//     public fun transfer<CoinType: drop>(from: &signer, to: address, amount: u64, _witness: CoinType) acquires Balance {
//         let check = withdraw<CoinType>(signer::address_of(from), amount);
//         deposit<CoinType>(to, check);
//     }

//     fun withdraw<CoinType>(addr: address, amount: u64) : Coin<CoinType>  acquires Balance{
//         let balance = balance_of<CoinType>(addr);
//         assert!(balance >= amount, EINSUFFICIENT_BALANCE);
//         let balance_ref = &mut borrow_global_mut<Balance<CoinType>>(addr).coin.value;
//         *balance_ref = balance - amount;
//         Coin<CoinType> { value: amount }
//     }

//     fun deposit<CoinType>(addr: address, check: Coin<CoinType>) acquires Balance {
//         let balance = balance_of<CoinType>(addr);
//         let balance_ref = &mut borrow_global_mut<Balance<CoinType>>(addr).coin.value;
//         let Coin { value } = check;
//         *balance_ref = balance + value;
//     }
// }
