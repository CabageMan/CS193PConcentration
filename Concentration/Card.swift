//
//  Card.swift
//  Concentration
//
//  Created by ViktorsMacbook on 10.12.18.
//  Copyright © 2018 Viktor Bednyi Inc. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    // Hashable and Equatable protocols implementation
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    // Declare variables
    
    var isFaceUp = false
    var isMatched = false
    var isSelectedBefore = false
    private var identifier: Int
    
    // Declare struct variable
    
    private static var identifierFactory = 0
    
    // Generate unique identifier for card instance
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    // New card instance initialization with unique identifier
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
