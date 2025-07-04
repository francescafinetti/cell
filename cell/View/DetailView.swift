//
//  DetailView.swift
//  cell
//
//  Created by Francesca Finetti on 03/07/25.
//

import SwiftUI

struct DetailView: View {
    let item: CellItem
    @ObservedObject var viewModel: CellListViewModel

    var body: some View {
        VStack(spacing: 20) {
            
            ZStack {

                Circle()
                    .fill(colorForName(item.title))
                    .frame(width: 200, height: 200)
                
                Text(initials(for: item.title))
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .padding(.top, 100)


            Text(item.title)
                .font(.title)

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
    
    func colorForName(_ name: String) -> Color {
        let hash = abs(name.hashValue)
        let hue = Double((hash % 256)) / 255.0
        return Color(hue: hue, saturation: 0.5, brightness: 0.9)
    }
    
    func initials(for name: String) -> String {
        let components = name.components(separatedBy: " ")
        let firstChar = components.first?.first.map(String.init) ?? ""
        let secondChar = components.dropFirst().first?.first.map(String.init) ?? ""
        return (firstChar + secondChar).uppercased()
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
