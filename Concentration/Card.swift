//
//  Card.swift
//  Concentration
//
//  Created by ViktorsMacbook on 10.12.18.
//  Copyright © 2018 Viktor Bednyi Inc. All rights reserved.
//

import Foundation

struct Card {
    
    // Declare variables
    
    var isFaceUp = false
    var isMatched = false
    var isSelectedBefore = false
    
    var identifier: Int
    
    // Declare struct variable
    
    static var identifierFactory = 0
    
    // Generate unique identifier for card instance
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    // New card instance initialization with unique identifier
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
