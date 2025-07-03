//
//  CellListView.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//
import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: CellListViewModel
    @State private var showingAddContact = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink(destination: DetailView(item: item, viewModel: viewModel)) {
                        HStack {
                            Text(item.title)
                            Spacer()
                            Button(action: {
                                viewModel.toggleFavorite(for: item)
                            }) {
                                Image(systemName: viewModel.isFavorite(item) ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteContact)
            }
            
            .navigationTitle("All Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddContact = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddContact) {
                AddContactView(viewModel: viewModel, isPresented: $showingAddContact)
            }
        }
    }
}
