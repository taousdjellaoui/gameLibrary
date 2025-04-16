import SwiftUI
import SwiftData

struct GameListView: View {
    enum Filter {
        case all, playing, completed
    }

    @Environment(\.modelContext) private var modelContext
    @Query var games: [Game]
    private var filter: Filter
    @State private var gameToEdit: Game? = nil
    let allGenres = ["Action", "Adventure", "RPG", "Strategy", "Simulation", "Horror", "Puzzle"]
       let platforms = ["PS5", "PS4", "Xbox Series X", "Xbox One", "Nintendo Switch", "PC", "Mobile"]

    

    init(filter: Filter = .all) {
        self.filter = filter
        let predicate: Predicate<Game>? = {
            switch filter {
            case .all:
                return nil
            case .playing:
                return #Predicate { !$0.isCompleted }
            case .completed:
                return #Predicate { $0.isCompleted }
            }
        }()
        _games = Query(filter: predicate, sort: \.title)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(games) { game in
                    NavigationLink(destination: GameDetailView(game: game)) {
                        HStack {
                            Image(systemName: game.isCompleted ? "checkmark.circle.fill" : "hourglass.circle.fill")
                                .foregroundStyle(game.isCompleted ? .green : .orange)
                            VStack(alignment: .leading) {
                                Text(game.title)
                                    .font(.headline)
                                Text(game.platform)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteGame)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(title(for: filter))
            .toolbar {
                Button(action: {
                                   // 👇 Insert a temporary game object before presenting the sheet
                                   let newGame = Game(
                                       title: "",
                                       platform: platforms.first ?? "Unknown",
                                       genre: allGenres.first ?? "Unknown",
                                       isCompleted: false,
                                       notes: ""
                                   )
                                   modelContext.insert(newGame)
                                   gameToEdit = newGame
                }) {
                    Label("Add Game", systemImage: "plus.circle.fill")
                }
            }
        }
        .sheet(item: $gameToEdit) { game in
                       NavigationStack {
                           GameDetailView(game: game,isNew: true)
                       }
                   }
    }

    private func title(for filter: Filter) -> String {
        switch filter {
        case .all:
            return "All Games"
        case .playing:
            return "Playing"
        case .completed:
            return "Completed"
        }
    }

 

    private func deleteGame(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(games[index])
        }
    }
}
#Preview {
    let previewContainer = try! ModelContainer(
        for: Game.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    let context = previewContainer.mainContext

    let sampleGame = Game(
        title: "Hollow Knight",
        platform: "Nintendo Switch",
        genre: "Metroidvania",
        isCompleted: false,
        notes: "Absolutely loved the art style."
    )
    context.insert(sampleGame)

    return GameListView(filter: .all)
        .modelContainer(previewContainer)
}
