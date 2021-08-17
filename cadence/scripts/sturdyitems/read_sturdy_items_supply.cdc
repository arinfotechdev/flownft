import SturdyItems from "../../contracts/SturdyItems.cdc"

// This scripts returns the number of SturdyItems currently in existence.

pub fun main(): UInt64 {    
    return SturdyItems.totalSupply
}
