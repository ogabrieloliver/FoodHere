//
//  CardView.swift
//  FoodHere
//
//  Created by O GabrielPro on 11/06/23.
//

import SwiftUI

struct CardView: View {
    let business: Business

    var body: some View {
        VStack {
            // Exibir a imagem do restaurante
            Image(business.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
            
            // Exibir o nome e a classificação do restaurante
            VStack {
                Text(business.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical, 8)
                
                Text("Classificação: \(business.rating)")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .padding()
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}


