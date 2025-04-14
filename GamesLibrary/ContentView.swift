import SwiftUI
import SwiftData

struct GameListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var games: [Game]

    var body: some View {
        NavigationStack {
            List {
                ForEach(games) { game in
                    NavigationLink(destination: GameDetailView(game: game)) {
                        HStack {
                           Image(systemName: game.isCompleted ? "checkmark.circle.fill" : "hourglass.circle.fill") .foregroundStyle(game.isCompleted ? .green : .orange)
                        }
                        VStack(alignment: .leading) {
                           
                            Text(game.title)
                                .font(.headline)
                            Text(game.platform)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                      
                    }
                }
                .onDelete(perform: deleteGame)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Games")
            .toolbar {
                Button(action: addGame) {
                    Label("Add Game", systemImage: "plus.circle.fill")
                }
            }
        }
    }

    private func addGame() {
        let newGame = Game(title: "New Game", platform: "Unknown", genre: "Unknown",notes:"")
        modelContext.insert(newGame)
    }

    private func deleteGame(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(games[index])
        }
    }
    private func IsCompleted(game:Game){
        if game.isCompleted{
            
        }
    }
    
}
#Preview {
    let previewContainer = try! ModelContainer(for: Game.self, configurations: .init(isStoredInMemoryOnly: true))
    let context = previewContainer.mainContext

    let sampleGame = Game(
        title: "Hollow Knight",
        platform: "Nintendo Switch",
        genre: "Metroidvania",
        isCompleted: false,
        notes: "Absolutely loved the art style."
    )
    context.insert(sampleGame)

    return GameListView()
        .modelContainer(previewContainer)
}
