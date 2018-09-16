//
//  ViewController.swift
//  Concentration
//
//  Created by Philip on 11.06.18.
//  Copyright © 2018 Philip. All rights reserved.
//

import UIKit

var emojiChoicesBackUp = ["👻", "🌼", "🚘", "🗿", "🐝", "🦀", "🦋"]
var emojiChoices = emojiChoicesBackUp


class ViewController: UIViewController {
    
    private lazy var game = Concentration(NumberOfPairsOfCards: NumberOfPairsOfCards)
    
    var NumberOfPairsOfCards: Int {
        return (CardButtons.count + 1) / 2 //"get" construction
    }
    
    private(set) var counterOfFlips = 0 {
        didSet {
            Score.text = "Score: " + String(counterOfFlips)
        }
    }

    @IBOutlet private var CardButtons: [UIButton]!
    
    
    var savePriviousCard = -1
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = CardButtons.index(of: sender) {
            //Part1
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        
            
            //Part2: Counting flips

            let card = game.cards[CardButtons.index(of: sender)!]
            
            
            if savePriviousCard != cardNumber && !card.isMatched && !game.checkGameIsOver() {
                counterOfFlips += 1
                savePriviousCard = cardNumber

            }else if savePriviousCard != cardNumber && card.isFaceUp && !game.checkGameIsOver(){
                counterOfFlips += 1
                savePriviousCard = cardNumber

            }
        }

        
        if game.checkGameIsOver() {
            updateNewGame()
        }
        
    }

    
    @IBOutlet weak private var Score: UILabel!
    
    private var Emoji =  [Int:String]() // Dictionary
    
    private func emoji(for card: Card) -> String {
        if Emoji[card.identifier] == nil, emojiChoices.count > 0 {
            Emoji[card.identifier] = emojiChoices.remove(at: Emoji.count.arc4random)
        }
        
        //if Emoji is nil return "?", else return Emoji
        return Emoji[card.identifier] ??  "?"
        
    }
    

    
    private func updateViewFromModel() {
        for index in CardButtons.indices {
            let button = CardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor =  card.isMatched ? #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 0.3333690068)  : #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            }
        }
    }
    
    
    private func updateNewGame() { //Flips all card
        game.restartGame()
        
        for index in CardButtons.indices {
            let button = CardButtons[index]
            let card = game.cards[index]
            if !card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
                button.setTitle("", for: UIControlState.normal)
            }
                
        }
        counterOfFlips = 0

            //TODO: Add button "Next game"
    }

}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self <  0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
