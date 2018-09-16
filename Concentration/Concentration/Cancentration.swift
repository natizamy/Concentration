//
//  Cancentration.swift
//  Concentration
//
//  Created by Philip on 17.06.2018.
//  Copyright © 2018 Philip. All rights reserved.
//

import Foundation


class Concentration {
    
    private(set) var cards = [Card]()
 
    private var IndexOfOnlyOneFaceUpCard :Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
                
            }
            return  foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
 

    
    func restartGame() {//Works only with cardArray. Compleating of view part is in ViewControler
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            IndexOfOnlyOneFaceUpCard = nil
        }
        cards = shuffleCards(ArrayToShuffle: cards)
    }
    
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index is not in the cards")
        if !cards[index].isMatched {
            if let MatchIndex = IndexOfOnlyOneFaceUpCard, MatchIndex != index {
                if cards[MatchIndex].identifier == cards[index].identifier {
                    cards[MatchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                //either 2 cards or no cards
                IndexOfOnlyOneFaceUpCard = index
            }
        }
    }
    
    
    init(NumberOfPairsOfCards:Int) {
        assert(NumberOfPairsOfCards > 0, "Concentration.init: incorrect number of cards")
        for _ in 1...NumberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = shuffleCards(ArrayToShuffle: cards)
    }


    
    func shuffleCards(ArrayToShuffle: [Card]) -> [Card] {
        
        var CopyEmojies      = ArrayToShuffle
        var ShuffeledEmojies = ArrayToShuffle //will be in future
        
        for i in 1...ArrayToShuffle.count {
            let randomNumber = Int(arc4random_uniform(UInt32(ArrayToShuffle.count) - UInt32(i) + 1))// 0..3
            
            ShuffeledEmojies[i-1] = CopyEmojies[randomNumber]
            CopyEmojies.remove(at: randomNumber)
        }
        return ShuffeledEmojies
    }
    
    func checkGameIsOver() -> Bool {
        var counter = 0
        for index in cards.indices {
            if cards[index].isMatched {
                counter += 1
            }
        }
        let twoCardsLasts = cards.count - 1
        return counter >= twoCardsLasts ? true : false
        
    }
    


    


}


