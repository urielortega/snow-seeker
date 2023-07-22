//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Uriel Ortega on 20/07/23.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    
    enum SortType {
    case defaultOrder, name, country
    }
    
    @State private var sortOrder = SortType.defaultOrder

    var body: some View {
        NavigationView {
            // Primary View:
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort.")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu {
                    Button("Default order") {
                        sortOrder = .defaultOrder
                    }
                    .accessibilityLabel("Sort by default order")
                    Button("Sort by name (A-Z)") {
                        sortOrder = .name
                    }
                    .accessibilityLabel("Sort by name, from A to Z")
                    Button("Sort by country") {
                        sortOrder = .country
                    }
                    .accessibilityLabel("Sort by country, from A to Z")
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
            
            // Secondary View:
            WelcomeView()
        }
        .environmentObject(favorites)
        .phoneOnlyStackNavigationView()
    }
    
    var filteredResorts: [Resort] {
        let result: [Resort]

        switch(sortOrder) {
        case .defaultOrder:
            result = resorts
        case .name:
            result = resorts.sorted { $0.name < $1.name }
        case .country:
            result = resorts.sorted { $0.country < $1.country }
        }
        
        if searchText.isEmpty {
            return result
        } else {
            return result.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
