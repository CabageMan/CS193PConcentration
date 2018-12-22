//
//  Concentration.swift
//  Concentration
//
//  Created by ViktorsMacbook on 10.12.18.
//  Copyright © 2018 Viktor Bednyi Inc. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = Array<Card>()
    var flipCount = 0
    var score = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    // Handle the main game logic
    
    func chooseCard (at index: Int) {
        flipCount += 1
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                // Check if cards match
                
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    // Increase score by 2
                    score += 2
                }
                
                // Check if choosen card is selected before
                if cards[index].isSelectedBefore, !cards[index].isMatched {
                    score -= 1
                } else {
                    cards[index].isSelectedBefore = true
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
            } else {
                
                // either no cards or 2 cards are face up
                
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                // Mark card as selected
                cards[index].isSelectedBefore = true
            }
        }
        
        
    }
    
    // Game initialization
    
    init(numberOfPairsOfCards: Int) {
        
        var nonShuffledCards = Array<Card>()
        
        // Fill the array of cards based on the number of pairs
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            nonShuffledCards += [card, card]
        }
        // Shuffle the cards
        for _ in 0..<nonShuffledCards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(nonShuffledCards.count)))
            cards.append(nonShuffledCards[randomIndex])
            nonShuffledCards.remove(at: randomIndex)
        }
    }
    
    deinit {
        print("Our game is deinit")
    }
}
