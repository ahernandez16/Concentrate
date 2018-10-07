//
//  Card.swift
//  Concentrate
//
//  Created by Arturo Hernandez on 8/11/18.
//  Copyright © 2018 Arturo Hernandez. All rights reserved.
//

import Foundation

struct Card
{
    // card is not face up.
    var isFaceUp = false
    
    // card is not matched.
    var isMatched = false
    
    // card has a unique id number.
    var identifier: Int
    
    // helping to generate and track unique id numbers for card.
    private static var identifierFactory = 0
    
    // Returns a unique ID number its type is 'Int'.
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    // initializes every card with a unique ID automatically.
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
