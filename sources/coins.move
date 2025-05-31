module coins::coins;

use std::option::some;
use sui::coin::{Self, TreasuryCap, create_currency};
use sui::url::new_unsafe_from_bytes;

const TOTAL_COINS: u64 = 1_000_000_000_000_000_000;

public struct COINS has drop {}

fun init(otw: COINS, ctx: &mut TxContext) {
    let (mut treasury, metadata) = coin::create_currency(
        otw,
        9,
        b"GAB",
        b"GAB",
        b"Money for Gab",
        option::some(new_unsafe_from_bytes(b"https://i.postimg.cc/T1JKX2Zg/Gabriel.png")),
        ctx,
    );
    mint(&mut treasury, TOTAL_COINS, ctx.sender(), ctx);
    transfer::public_freeze_object(metadata);
    transfer::public_transfer(treasury, ctx.sender())
}

public fun mint(
    treasury_Cap: &mut TreasuryCap<COINS>,
    amount: u64,
    recipient: address,
    ctx: &mut TxContext,
) {
    let coin = coin::mint(treasury_Cap, amount, ctx);
    transfer::public_transfer(coin, recipient);
}
