//
//  CardStackView.swift
//  FoodHere
//
//  Created by O GabrielPro on 11/06/23.
//
import SwiftUI

struct CardStackView: View {
    @ObservedObject var viewModel = CardStackViewModel()
    
    var body: some View {
        VStack {
            if viewModel.businesses.isEmpty {
                Text("Carregando...")
            } else {
                ZStack {
                    ForEach(viewModel.businesses, id: \.name) { business in
                        CardView(business: business)
                            .padding(16)
                    }
                }
                .onAppear {
                    viewModel.loadBusinesses()
                }
            }
            
            HStack {
                Button(action: {
                    // Lógica para exibir o próximo cartão
                }) {
                    Text("Próximo")
                }
                .padding()
                
                Button(action: {
                    // Lógica para exibir o cartão anterior
                }) {
                    Text("Anterior")
                }
                .padding()
            }
        }
    }
}




