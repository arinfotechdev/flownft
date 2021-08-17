import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"
import SturdyItems from "../../contracts/SturdyItems.cdc"

// This transaction configures an account to hold Sturdy Items.

transaction {
    prepare(signer: AuthAccount) {
    
   		log("Hello, World!")
        log(signer.address)
        // if the account doesn't already have a collection
        if signer.borrow<&SturdyItems.Collection>(from: SturdyItems.CollectionStoragePath) == nil {

            // create a new empty collection
            let collection <- SturdyItems.createEmptyCollection()
            
            // save it to the account
            signer.save(<-collection, to: SturdyItems.CollectionStoragePath)

            // create a public capability for the collection
            signer.link<&SturdyItems.Collection{NonFungibleToken.CollectionPublic, SturdyItems.SturdyItemsCollectionPublic}>(SturdyItems.CollectionPublicPath, target: SturdyItems.CollectionStoragePath)
        }
    }
}
