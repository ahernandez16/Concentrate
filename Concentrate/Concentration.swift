//
//  Concentration.swift
//  Concentrate
//
//  Created by Arturo Hernandez on 8/11/18.
//  Copyright © 2018 Arturo Hernandez. All rights reserved.
//

import Foundation

struct Concentration
{
    // array of cards using the 'Card' object
    private(set) var cards = [Card]()
    
    // optional var to check if there are any turned up cards
    // Computed variable
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        foundIndex = nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // Whenever a card is chosen it will change that 'card's properties to wether it is matched, no cards, 2 cards are face up
    mutating func chooseCard(at index: Int) {
        //
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else { 
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // flip cards and matching status back to original state
    mutating func resetGame(){
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    // initializer will create a set of pairs based on the number of card buttons
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards" )
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
    }
    
}
