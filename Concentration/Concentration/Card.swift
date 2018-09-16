//
//  Card.swift
//  Concentration
//
//  Created by Philip on 17.06.2018.
//  Copyright © 2018 Philip. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static private var identifierFactory = 0
    
    static private func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    
}
