//
//  CellListViewModel.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//
import SwiftUI

class CellListViewModel: ObservableObject {
    @Published var items: [CellItem] = (1...10).map {
        CellItem(title: "Cell number \($0)", isFavorite: false)
    }

    func toggleFavorite(for item: CellItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isFavorite.toggle()
        }
    }
}
