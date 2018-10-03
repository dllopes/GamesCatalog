//
//  game.swift
//  GamesCatalog
//
//  Created by Diego Lopes on 02/10/18.
//  Copyright © 2018 Diego Lopes. All rights reserved.
//

import Foundation

class Game {
    let title: String
    let year: Date
    let console: String
    let completed: Bool
    let dateOfCompletion: Date
    let personalNotes: String
    
    init(title: String, year: Date, console: String, completed: Bool, dateOfCompletion: Date, personalNotes: String) {
        self.title = title
        self.year = year
        self.console = console
        self.completed = completed
        self.dateOfCompletion = dateOfCompletion
        self.personalNotes = personalNotes
    }
}
