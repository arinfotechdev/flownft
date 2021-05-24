import StrudyItems from "../../contracts/StrudyItems.cdc"

// This scripts returns the number of StrudyItems currently in existence.

pub fun main(): UInt64 {    
    return StrudyItems.totalSupply
}
