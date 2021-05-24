import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"
import StrudyItems from "../../contracts/StrudyItems.cdc"

// This transaction configures an account to hold Strudy Items.

transaction {
    prepare(signer: AuthAccount) {
    
   		log("Hello, World!")
        log(signer.address)
        // if the account doesn't already have a collection
        if signer.borrow<&StrudyItems.Collection>(from: StrudyItems.CollectionStoragePath) == nil {

            // create a new empty collection
            let collection <- StrudyItems.createEmptyCollection()
            
            // save it to the account
            signer.save(<-collection, to: StrudyItems.CollectionStoragePath)

            // create a public capability for the collection
            signer.link<&StrudyItems.Collection{NonFungibleToken.CollectionPublic, StrudyItems.StrudyItemsCollectionPublic}>(StrudyItems.CollectionPublicPath, target: StrudyItems.CollectionStoragePath)
        }
    }
}
