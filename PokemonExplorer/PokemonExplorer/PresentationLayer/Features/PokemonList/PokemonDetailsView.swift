//
//  PokemonDetailsView.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import SwiftUI
import Kingfisher

struct PokemonDetailsView: View {
    let name: String?
    
    @StateObject var viewModel = PokemonDetailsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            pokeName
            pokeStats
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
        Text(name?.capitalizingFirstLetter() ?? "")
            .font(.title3)
            .padding(.leading, 8)
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
}
