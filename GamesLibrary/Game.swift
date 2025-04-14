//
//  Item.swift
//  GamesLibrary
//
//  Created by Taous  Djellaoui  on 2025-02-03.
//

import Foundation
import SwiftData

@Model
class Game {
    var title: String
    var platform: String
    var genre: String
    var releaseDate: Date?
    var isCompleted: Bool
    var notes: String?

    init(title: String, platform: String, genre: String, releaseDate: Date? = nil, isCompleted: Bool = false, notes: String? = nil) {
        self.title = title
        self.platform = platform
        self.genre = genre
        self.releaseDate = releaseDate
        self.isCompleted = isCompleted
        self.notes = notes
    }
}
