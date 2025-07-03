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
        CellItem(id: UUID(), title: "Alessandro Rossi"),
        CellItem(id: UUID(), title: "Giulia Bianchi"),
        CellItem(id: UUID(), title: "Marco Esposito"),
        CellItem(id: UUID(), title: "Francesca Moretti"),
        CellItem(id: UUID(), title: "Luca Conti"),
        CellItem(id: UUID(), title: "Martina Greco"),
        CellItem(id: UUID(), title: "Davide Ferrara"),
        CellItem(id: UUID(), title: "Sara Romano"),
        CellItem(id: UUID(), title: "Federico Galli"),
        CellItem(id: UUID(), title: "Elisa Fontana")
    ]
    
    @AppStorage("favoriteIDs") private var favoriteIDStrings: String = ""

    var favoriteIDs: Set<UUID> {
        get {
            Set(favoriteIDStrings
                .split(separator: ",")
                .compactMap { UUID(uuidString: String($0)) }
            )
        }
        set {
            favoriteIDStrings = newValue.map { $0.uuidString }.joined(separator: ",")
        }
    }

    func isFavorite(_ item: CellItem) -> Bool {
        favoriteIDs.contains(item.id)
    }

    func toggleFavorite(for item: CellItem) {
        var updated = favoriteIDs
        if updated.contains(item.id) {
            updated.remove(item.id)
        } else {
            updated.insert(item.id)
        }
        favoriteIDs = updated
        objectWillChange.send() // forza aggiornamento
    }
}
