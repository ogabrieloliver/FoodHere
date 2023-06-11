//
//  ContentView.swift
//  FoodHere
//
//  Created by O GabrielPro on 11/06/23.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CardStackViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.businesses.isEmpty {
                    Text("Carregando...")
                } else {
                    ZStack {
                        ForEach(viewModel.businesses, id: \.name) { business in
                            CardView(business: Business: business)
                                .padding(16)
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < -100 {
                                    viewModel.nextCard()
                                } else if value.translation.width > 100 {
                                    viewModel.previousCard()
                                }
                            }
                    )
                }
                
                HStack {
                    Button(action: {
                        viewModel.swipeRight()
                    }) {
                        Text("Anterior")
                    }
                    .padding()
                    
                    Button(action: {
                        viewModel.swipeLeft()
                        
                    }) {
                        Text("Próximo")
                    }
                    .padding()
                }
                .disabled(viewModel.businesses.isEmpty)
                .opacity(viewModel.businesses.isEmpty ? 0.5 : 1.0)
            }
            .navigationTitle("Restaurantes")
        }
        .onAppear {
            viewModel.loadBusinesses()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

