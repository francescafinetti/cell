//
//  CellListViewModel.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//
import SwiftUI


class CellListViewModel: ObservableObject {
    @AppStorage("contactsData") private var contactsData: Data = Data()
    @AppStorage("favoriteIDs") private var favoriteIDStrings: String = ""

    @Published var items: [CellItem] = []

    init() {
        loadContacts()
    }

    //some fake names just to avoid "CELL NUMBER 1-2-3.."

    private func loadContacts() {
        guard let decoded = try? JSONDecoder().decode([CellItem].self, from: contactsData) else {
            items = [
                CellItem(id: UUID(), title: "Alessandro Rossi"),
                CellItem(id: UUID(), title: "Giulia Bianchi"),
                CellItem(id: UUID(), title: "Francesca Moretti"),
            ]
            saveContacts()
            return
        }
        items = decoded
    }

    func saveContacts() {
        if let encoded = try? JSONEncoder().encode(items) {
            contactsData = encoded
        }
    }

    func addContact(named name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let newContact = CellItem(id: UUID(), title: trimmed)
        items.append(newContact)
        saveContacts()
    }

    func deleteContact(at offsets: IndexSet) {
        let removed = offsets.map { items[$0] }

        for contact in removed {
            favoriteIDs.remove(contact.id)
        }

        items.remove(atOffsets: offsets)
        saveContacts()
    }


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
        objectWillChange.send()
    }
}
