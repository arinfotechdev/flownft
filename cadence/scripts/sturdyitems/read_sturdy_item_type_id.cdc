import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"
import SturdyItems from "../../contracts/SturdyItems.cdc"

// This script returns the metadata for an NFT in an account's collection.

pub fun main(address: Address, itemID: UInt64): UInt64 {

    // get the public account object for the token owner
    let owner = getAccount(address)

    let collectionBorrow = owner.getCapability(SturdyItems.CollectionPublicPath)!
        .borrow<&{SturdyItems.SturdyItemsCollectionPublic}>()
        ?? panic("Could not borrow SturdyItemsCollectionPublic")

    // borrow a reference to a specific NFT in the collection
    let SturdyItem = collectionBorrow.borrowSturdyItem(id: itemID)
        ?? panic("No such itemID in that collection")

    return SturdyItem.typeID
}
