//
//  Concentration.swift
//  Concentration
//
//  Created by ViktorsMacbook on 10.12.18.
//  Copyright © 2018 Viktor Bednyi Inc. All rights reserved.
//

import Foundation

class Concentration {
    
    private (set) var cards = Array<Card>()
    var flipCount = 0
    var score = 0
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            // Change for in by closure
            let faceUpCardIndices = cards.indices.filter{cards[$0].isFaceUp}
            // Give me all the face card indices by filtering the indices to show me the ones that are face up
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            /*
            var foundIndex: Int? = nil
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
            */
        }
        set (newValue) {
            for index in cards.indices {
                // Set is faceUp property of card to true if index is mathed with newvalue index
                // Else set other cards isFaceUp property to false
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // Handle the main game logic
    
    func chooseCard (at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard (at: \(index)): choosen index not in the cards")
        flipCount += 1
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                // Check if cards match and check if choosen cards is selected before
                
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    // Increase score by 2
                    score += 2
                } else if cards[index].isSelectedBefore {
                    score -= 1
                } else {
                    cards[index].isSelectedBefore = true
                }
                
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
                // Mark card as selected
                cards[index].isSelectedBefore = true
            }
        }
        
        
    }
    
    // Game initialization
    
    init(numberOfPairsOfCards: Int) {
        
        assert(numberOfPairsOfCards > 0, "Concentration init(\(numberOfPairsOfCards): you must have at least one pair of cards")
        
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
