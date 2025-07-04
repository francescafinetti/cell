//
//  FavoritesView.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: CellListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.items.filter { viewModel.isFavorite($0) }) { item in
                NavigationLink(destination: DetailView(item: item, viewModel: viewModel)) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(colorForName(item.title))
                            .font(.system(size: 24))

                        Text(item.title)
                            .font(.body)

                        Spacer()

                        Button(action: {
                            viewModel.toggleFavorite(for: item)
                        }) {
                            Image(systemName: viewModel.isFavorite(item) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
    func colorForName(_ name: String) -> Color {
        let hash = abs(name.hashValue)
        let hue = Double((hash % 256)) / 255.0
        return Color(hue: hue, saturation: 0.5, brightness: 0.9)
    }
    
    func initials(for name: String) -> String {
        let components = name.components(separatedBy: " ")
        let firstChar = components.first?.first.map(String.init) ?? ""
        let secondChar = components.dropFirst().first?.first.map(String.init) ?? ""
        return (firstChar + secondChar).uppercased()
    }
}
