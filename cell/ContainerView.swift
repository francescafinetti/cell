//
//  ContainerView.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//

import SwiftUI

struct ContainerView: View {
    @StateObject private var viewModel = CellListViewModel()

    var body: some View {
        TabView {
            ListView(viewModel: viewModel)
                .tabItem {
                    Label("All", systemImage: "list.bullet")
                }

            FavoritesView(viewModel: viewModel)
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    ContainerView()
}
