//
//  PokemonListView.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        Group {
            title
            pokemonList
        }
        .background(.bgGreen)
    }
    
    var title: some View {
        Text("Pokemon Explorer")
            .font(.title)
    }
    
    var pokemonList: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.pokemon, id:\.self) { pokemon in
                    PokemonDetailsView(name: pokemon.name)
                }
            }
            .padding(.horizontal, 18)
        }
    }
}

