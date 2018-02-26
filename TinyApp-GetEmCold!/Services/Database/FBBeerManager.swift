//
//  FBBeerManager.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/24/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

enum FirebaseBeerStatus: Error {
    case BeerNotAdded
    case errorParsingBeerData
    case BeerDidNotUpdate
    case BeerNotDeleted
}

protocol FirebaseBeerManagerDelegate: class {
    //Add beer protocols
    func addBeer(_ userService: FirebaseBeerManager, beerObject: Beer)
    func failedToAddBeer(_ userService: FirebaseBeerManager, error: Error)
    
    //Retrieve beer protocols
    func getBeer(_ userService: FirebaseBeerManager, beerObject: Beer)
    func failToGetBeer(_ userService: FirebaseBeerManager, error: Error)
    
    //Deleting beer protocols
    func deleteBeer(_ userService: FirebaseBeerManager, withBeerUID beerUID: String)
    func failedToDeleteBeer(_ userService: FirebaseBeerManager, error: Error)
    
    //Update beer protocols
    //    func updateFlashCard(_ userService: FirebaseCardManager, beerObject: Beer)
    //    func failedToUpdateFlashCard(_ userService: FirebaseCardManager, error: Error)
}

//MARK: Automtically makes the functions optional without needing to have it conform to NSObject: Must have an implementation
extension FirebaseBeerManagerDelegate {
    
}

class FirebaseBeerManager {
    private init(){
        //root reference
        let dbRef = Database.database().reference()
        //child of the root
        beerRef = dbRef.child("beer")
    }
    
    
    private var beerRef: DatabaseReference!
    static let manager = FirebaseBeerManager()
    weak var delegate: FirebaseBeerManagerDelegate?
    
    //Add beer to firebase..
    public func addBeerToFirebase(id: Int, name: String, tagline: String, first_brewed: String, description: String, image_url: String, abv: Double){
        //creating a unique key identifier
        let childByAutoID = Database.database().reference(withPath: "beer").child(name) //the autoID will the beers name
        //let childKey = childByAutoID.key
        var beer: Beer
        beer = Beer(id: id, name: name, tagline: tagline, first_brewed: first_brewed, description: description, abv: abv, image_url: image_url)
        //setting the value of the beer
        childByAutoID.setValue((beer.beerToJSON())) { (error, dbRef) in
            if let error = error {
                self.delegate?.failedToAddBeer(self, error: FirebaseBeerStatus.BeerNotAdded)
                print("failed to add beer error: \(error)")
            } else {
                self.delegate?.addBeer(self, beerObject: beer) // in extension call addFlashCardToCategory func
                print("beer saved to dbRef: \(dbRef)")
            }
        }
    }
}

//    //Gets all of the flashcard.. Helper Function that is used in get all flashcards
//    public func getFlashCard(_ cardUID: String, completion: @escaping (_ flashCard: FlashCard) -> Void){
//        //get reference to cardUID
//        let cardUIDRef = cardRef.child(cardUID)
//        //observe single event and if the the cardUIDs value is json
//        cardUIDRef.observeSingleEvent(of: .value) { (cardUIDSnapshot) in
//            if let json = cardUIDSnapshot.value{
//                do{
//                    //serialize cardUID object
//                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
//                    //decode the category object
//                    let flashcard = try JSONDecoder().decode(FlashCard.self, from: jsonData)
//                    //run completion on flashcard
//                    completion(flashcard)
//                }catch {
//                    //catch the error
//                    print("unable to get flashcard with error: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//
//    //Gets ALL of the flashcards from specific category name...WORKS!!!
//    public func getAllFlashCards(fromCategories category: Category, completion: @escaping (_ flashCard: [FlashCard]?) -> Void){
//        //make sure flashcard UID's exist
//        //guard let flashcardUIDs = category.flashCards else {print("User has no flashcards");return}
//
//        //grabbing flashcard bucket
//        var flashcards = [FlashCard](){
//            didSet{
//                completion(flashcards)
//            }
//        }
//        var fcArr = ["-L5v6MM_w_7M75tvWcnz", "-L5v69pRG2xPsFmwgr17"]
//        //iterate thru bucket and append every flashcard to that flashcard bucket
//        for cardUID in fcArr{
//            DispatchQueue.main.async {
//                //call getFlashcard function and append flashcard to flashcard bucket
//                self.getFlashCard(cardUID){flashcards.append($0)}
//            }
//        }
//    }
//
//    //////////////////////////////////////////////
//
//    //Updates a single flashCard for a single user.
//    public func updateFlashCard(withcardUID cardUID: String, userUID: String, updatedFlashCard: FlashCard){
//        //Specific flashcard ref based on that cards id
//        let cardIDRef = cardRef.child(cardUID)
//        let flashCard: FlashCard
//        //Initialize flashcard with updated information
//        flashCard = FlashCard(cardUID: cardUID,
//                              userUID: userUID,
//                              categoryUID: updatedFlashCard.categoryUID,
//                              term: updatedFlashCard.term,
//                              definition: updatedFlashCard.definition)
//        //updating the values at that specific flashcard via downcasting
//        cardIDRef.updateChildValues((flashCard.flashCardToJSON() as! [AnyHashable : Any])) { (error, _) in
//            if let error = error {
//                self.delegate?.failedToUpdateFlashCard(self, error: FirebaseCardStatus.flashCardDidNotUpdate)
//                print("flashcard failed to update with error: \(error)")
//            } else {
//                self.delegate?.updateFlashCard(self, card: flashCard)
//                print("flashcard did update with id: \(cardUID)")
//            }
//        }
//    }
//
//
//    //Deletes flashCard at it's specific cardUID
//    public func deleteFlashCard(withCardID cardUID: String){
//        //get post reference
//        cardRef.child(cardUID).removeValue{ (error, _) in
//            if let error = error {
//                self.delegate?.failedToDeleteFlashCard(self, error: FirebaseCardStatus.flashCardNotDeleted)
//                print("Error deleting flashCard: \(error.localizedDescription)")
//            } else {
//                self.delegate?.deleteFlashCard(self, withCardUID: cardUID)
//            }
//        }
//    }


