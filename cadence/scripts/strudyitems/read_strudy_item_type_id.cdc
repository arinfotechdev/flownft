import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"
import StrudyItems from "../../contracts/StrudyItems.cdc"

// This script returns the metadata for an NFT in an account's collection.

pub fun main(address: Address, itemID: UInt64): UInt64 {

    // get the public account object for the token owner
    let owner = getAccount(address)

    let collectionBorrow = owner.getCapability(StrudyItems.CollectionPublicPath)!
        .borrow<&{StrudyItems.StrudyItemsCollectionPublic}>()
        ?? panic("Could not borrow StrudyItemsCollectionPublic")

    // borrow a reference to a specific NFT in the collection
    let StrudyItem = collectionBorrow.borrowStrudyItem(id: itemID)
        ?? panic("No such itemID in that collection")

    return StrudyItem.typeID
}
