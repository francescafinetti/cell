//
//  CellItem.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//

import SwiftUI

struct CellItem: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    var imageData: Data? = nil  // futura immagine

}
