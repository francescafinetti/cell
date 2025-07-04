//
//  DetailView.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//

import SwiftUI
import PhotosUI

struct DetailView: View {
    let item: CellItem
    @ObservedObject var viewModel: CellListViewModel
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var imageSelection: PhotosPickerItem? = nil
    @State private var showPhotoOptions = false

    var body: some View {
        VStack(spacing: 20) {
            
            ZStack {
                if let data = item.imageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(colorForName(item.title))
                        .frame(width: 200, height: 200)

                    Text(initials(for: item.title))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                }
            }
            .onTapGesture {
                showImagePicker = true
            }
            .onLongPressGesture {
                showPhotoOptions = true
            }
            .actionSheet(isPresented: $showPhotoOptions) {
                ActionSheet(
                    title: Text("Modifica immagine"),
                    buttons: [
                        .destructive(Text("Rimuovi foto")) {
                            if let index = viewModel.items.firstIndex(where: { $0.id == item.id }) {
                                viewModel.items[index].imageData = nil
                                viewModel.saveContacts()
                            }
                        },
                        .cancel()
                    ]
                )
            }
            .onTapGesture {
                showImagePicker = true
            }
            .photosPicker(isPresented: $showImagePicker, selection: $imageSelection, matching: .images)
            .onChange(of: imageSelection) { newItem in
                Task {
                    if let imageData = try? await newItem?.loadTransferable(type: Data.self),
                       let index = viewModel.items.firstIndex(where: { $0.id == item.id }) {
                        viewModel.items[index].imageData = imageData
                        viewModel.saveContacts()
                    }
                }
            }
            .padding(.top, 100)
            


            Text(item.title)
                .font(.title)
                .bold()

            Button(action: {
                viewModel.toggleFavorite(for: item)
            }) {
                Image(systemName: viewModel.isFavorite(item) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .font(.largeTitle)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}






struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleItem = CellItem(id: UUID(), title: "Francesca Finetti")
        let viewModel = CellListViewModel()
        viewModel.items = [exampleItem]

        return DetailView(item: exampleItem, viewModel: viewModel)
    }
}
