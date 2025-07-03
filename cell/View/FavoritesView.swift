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
                        Text(item.title)
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
}
