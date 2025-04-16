//
//  SidebarView.swift
//  GamesLibrary
//
//  Created by Taous  Djellaoui  on 2025-04-14.
//

import SwiftUI

struct SidebarView: View {
    enum Menu: String, CaseIterable, Identifiable {
        case all = "All Games"
        case playing = "Playing"
        case completed = "Completed"

        
        var id: String {rawValue}
        
        
    }
    @State private var selection : Menu? = nil
    
    var body: some View {
        NavigationSplitView {
            List(Menu.allCases, selection: $selection) { item in
                Label(item.rawValue, systemImage: icon(for : item))
                    .tag(item)
            }
            .navigationTitle("Home")
        }detail: {
           switch selection {
           case .all:
               GameListView(filter: .all)
           case .playing:
               GameListView(filter: .playing)
           case .completed:
               GameListView(filter: .completed)
          
           default:
               Text("Select a  category")
           
            }
        }
        
    }
    private func icon(for menu: Menu) -> String {
        switch menu {
        case .all: return "list.bullet"
        case .playing: return "gamecontroller"
        case .completed: return "checkmark"

           
        }
    }
}

