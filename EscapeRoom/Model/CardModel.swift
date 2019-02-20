//
//  CardModel.swift
//  EscapeRoom
//
//  Created by Matilda Dahlberg on 2019-02-12.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import Foundation


class CardModel {
    
    func getCards() -> [Card] {
        
        //array of cards
        var generatedCardsArray = [Card]()
        
        
        //random generate pair of cards
        for _ in 1...6{
            
           let randomNumber = arc4random_uniform(3) + 1
            
            print(randomNumber)
            
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            
            generatedCardsArray.append(cardOne)
            
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"

            generatedCardsArray.append(cardTwo)
            
        }
        
        //random the array
        
        //return the array
        return generatedCardsArray
    }
}

