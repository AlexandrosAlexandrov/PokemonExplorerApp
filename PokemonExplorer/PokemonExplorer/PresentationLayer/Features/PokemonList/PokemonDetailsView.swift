//
//  PokemonDetailsView.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import SwiftUI
import Kingfisher

struct PokemonDetailsView: View {
    @StateObject var viewModel = PokemonDetailsViewModel()
    
    let name: String?
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                pokeName
                pokeStats
            }
            
            loader
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.black)
        )
        .onAppear {
            viewModel.fetchPokemonDetails(name: name ?? "")
        }
        .background(.bgBlue)
        
    }
    
    var sprite: some View {
        KFImage(URL(string: viewModel.pokemonDetails?.sprites?.defaultSprite ?? ""))
    }
    
    var pokeName: some View {
        HStack {
            Text(name?.capitalizingFirstLetter() ?? "")
                .font(.title3)
            
            Spacer()
            
            Image(systemName: "heart")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.top, 5)
                .onTapGesture {
                    print("\(name ?? "") is now favorite!")
                }
        }
        .padding(.horizontal, 8)
    }
    
    var pokeStats: some View {
        HStack(spacing: 16) {
            sprite
            statsList
        }
    }
    
    var statsList: some View {
        VStack(alignment: .leading) {
            Text("HP: \(viewModel.getPokemonStat(.hp))")
            Text("Attack: \(viewModel.getPokemonStat(.attack))")
            Text("Defense: \(viewModel.getPokemonStat(.defense))")
        }
    }
    
    @ViewBuilder
    var loader: some View {
        if viewModel.loading {
            ProgressView()
        }
    }
}
