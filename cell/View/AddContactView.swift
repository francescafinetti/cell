//
//  AddContactView.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//

import SwiftUI
struct AddContactView: View {
    @ObservedObject var viewModel: CellListViewModel
    @Binding var isPresented: Bool

    @State private var name: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Contact")) {
                    TextField("Full name", text: $name)
                }
            }
            .navigationTitle("Add Contact")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.addContact(named: name)
                        isPresented = false
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
