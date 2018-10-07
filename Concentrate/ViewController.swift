//
//  ViewController.swift
//  Concentrate
//
//  Created by Arturo Hernandez on 8/8/18.
//  Copyright © 2018 Arturo Hernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    // initiates a game of Concentration with a proportionate sets of cards to buttons.
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // Computed property that returns the number of pairs of cards read-only
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    // tracks & updates the number of flips through out game.
    private var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // Outlet: UI label variable to compute number of flips.
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    // Outlet: array of buttons to be used by game as cards.
    @IBOutlet private var cardButtons: [UIButton]!
    
    // Action: new game button will reset a new game and number of flips.
    @IBAction private func newGame(_ sender: UIButton) {
        flipCount = 0
        game.resetGame()
        updateViewFromModel()
    }
    
    // Action: when a card button is pressed it will flip it, update the flipCount and update the game.
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    // function will update the view from model checks the current card status.
    // calls on model to decide how card is being played in concentration game.
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    func resetCards() {
        
    }
    
    // Array of emoji choices - Halloween theme.
    private var emojiChoices = ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎", "🕸"]
    
    // Dictionary called emoji that takes an 'int' for the id and a 'string' for the emoji.
    private var emoji = [Int:String]()
    
    // Returns an emoji for a card object.
    // choose a random emoji from the array of 'emojiChoices' and remove it from the array.
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
}

// Gives us a random int
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
