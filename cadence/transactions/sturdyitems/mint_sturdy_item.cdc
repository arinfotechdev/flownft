import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"
import SturdyItems from "../../contracts/SturdyItems.cdc"

// This transction uses the NFTMinter resource to mint a new NFT.
//
// It must be run with the account that has the minter resource
// stored at path /storage/NFTMinter.

transaction(recipient: Address, 
	typeID: UInt64, 
	tokenURI: String, 
	tokenTitle: String, 
    tokenDescription: String, 
    artist: String, 
    secondaryRoyalty: String, 
    platformMintedOn: String) {
    
    // local variable for storing the minter reference
    let minter: &SturdyItems.NFTMinter

    prepare(signer: AuthAccount) {
        // borrow a reference to the NFTMinter resource in storage
        self.minter = signer.borrow<&SturdyItems.NFTMinter>(from: SturdyItems.MinterStoragePath)
            ?? panic("Could not borrow a reference to the NFT minter")
    }

    execute {
        // get the public account object for the recipient
        let recipient = getAccount(recipient)

        // borrow the recipient's public NFT collection reference
        let receiver = recipient
            .getCapability(SturdyItems.CollectionPublicPath)!
            .borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")

        // mint the NFT and deposit it to the recipient's collection
        self.minter.mintNFT(recipient: receiver, 
        	typeID: typeID, 
        	tokenURI: tokenURI, 
        	tokenTitle: tokenTitle, 
        	tokenDescription: tokenDescription,
            artist: artist, 
            secondaryRoyalty: secondaryRoyalty, 
            platformMintedOn: platformMintedOn)
    } 
}
