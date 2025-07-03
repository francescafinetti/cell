//
//  DetailView.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//

import SwiftUI

struct DetailView: View {
    let item: CellItem
    @ObservedObject var viewModel: CellListViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text(item.title).font(.largeTitle)

            Button(action: {
                viewModel.toggleFavorite(for: item)
            }) {
                Image(systemName: item.isFavorite ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .font(.largeTitle)
            }
        }
        .padding()
        .navigationTitle("Details")
    }
}
