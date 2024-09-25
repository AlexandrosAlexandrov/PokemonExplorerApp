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
        ScrollView {
            LazyVStack {
                ForEach(viewModel.pokemon, id:\.self) { pokemon in
                    Text(pokemon.name ?? "")
                }
            }
            .padding()
        }
    }
}

