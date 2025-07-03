//
//  CellListView.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//
import SwiftUI

struct CellListView: View {
    @StateObject private var viewModel = CellListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.items) { item in
                NavigationLink(destination: DetailView(item: item, viewModel: viewModel)) {
                    HStack {
                        Text(item.title)
                        Spacer()
                        Button(action: {
                            viewModel.toggleFavorite(for: item)
                        }) {
                            Image(systemName: item.isFavorite ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            .navigationTitle("List")
        }
    }
}

#Preview{
    CellListView()
}
