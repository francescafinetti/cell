//
//  ContentView.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//

import SwiftUI

struct CellItem: Identifiable {
    let id = UUID()
    var title: String
    var isFavorite: Bool
}
