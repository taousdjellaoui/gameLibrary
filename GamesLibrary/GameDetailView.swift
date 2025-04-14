//
//  GameDetailView.swift
//  GamesLibrary
//
//  Created by Taous  Djellaoui  on 2025-03-19.


import SwiftUI

struct GameDetailView: View {
    @Bindable var game: Game
    @State private var notes: String

    init(game: Game) {
        self.game = game
        _notes = State(initialValue: game.notes ?? "")
    }

    let allGenres = ["Action", "Adventure", "RPG", "Strategy", "Simulation", "Horror", "Puzzle"]
    let platforms = ["PS5", "PS4", "Xbox Series X", "Xbox One", "Nintendo Switch", "PC", "Mobile"]

    var body: some View {
        Form {
            TextField("Title", text: $game.title)
            Picker("Platform", selection: $game.platform) {
                ForEach(platforms, id: \.self) { platform in
                    Text(platform)
                }
            }
            Picker("Genre", selection: $game.genre) {
                ForEach(allGenres, id: \.self) { genre in
                    Text(genre)
                }
            }

            Toggle("Completed", isOn: $game.isCompleted)

            TextEditor(text: $notes)
                .frame(height: 100)
        }
        .onDisappear {
            game.notes = notes
        }
        .navigationTitle(game.title)
    }
}
#Preview {
   
        GameDetailView(game: Game(
            title: "Zelda: Tears of the Kingdom",
            platform: "Nintendo Switch",
            genre: "Adventure",
            releaseDate: Date(),
            isCompleted: false,
            notes: "Still exploring the Depths"
        ))
}
