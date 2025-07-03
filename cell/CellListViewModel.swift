//
//  CellListViewModel.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//
import SwiftUI

//some fake names just to avoid "CELL NUMBER 1-2-3.."

class CellListViewModel: ObservableObject {
    @Published var items: [CellItem] = [
        CellItem(title: "Alessandro Rossi", isFavorite: false),
        CellItem(title: "Giulia Bianchi", isFavorite: false),
        CellItem(title: "Marco Esposito", isFavorite: false),
        CellItem(title: "Francesca Moretti", isFavorite: false),
        CellItem(title: "Luca Conti", isFavorite: false),
        CellItem(title: "Martina Greco", isFavorite: false),
        CellItem(title: "Davide Ferrara", isFavorite: false),
        CellItem(title: "Sara Romano", isFavorite: false),
        CellItem(title: "Federico Galli", isFavorite: false),
        CellItem(title: "Elisa Fontana", isFavorite: false)
    ]
    
    func toggleFavorite(for item: CellItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isFavorite.toggle()
        }
    }
}
