import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"
import SturdyItems from "../../contracts/SturdyItems.cdc"

// This script returns the size of an account's SturdyItems collection.

pub fun main(address: Address): Int {
    let account = getAccount(address)

    let collectionRef = account.getCapability(SturdyItems.CollectionPublicPath)!
        .borrow<&{NonFungibleToken.CollectionPublic}>()
        ?? panic("Could not borrow capability from public collection")
    
    return collectionRef.getIDs().length
}
