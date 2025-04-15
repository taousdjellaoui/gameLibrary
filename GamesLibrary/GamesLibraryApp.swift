//
//  GamesLibraryApp.swift
//  GamesLibrary
//
//  Created by Taous  Djellaoui  on 2025-02-03.
//

import SwiftUI
import SwiftData

@main
struct GameLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            SidebarView()
        }
        .modelContainer(for: Game.self)
    }
}
