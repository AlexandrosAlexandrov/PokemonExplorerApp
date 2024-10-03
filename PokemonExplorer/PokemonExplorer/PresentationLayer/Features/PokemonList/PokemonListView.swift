//
//  PokemonListView.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import SwiftUI
import DomainLayer

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        ZStack {
            mainView
            loader
        }
        .padding(.horizontal, 18)
        .background(.bgGreen)
        .onChange(of: viewModel.typeSelection) {
            viewModel.fetchPokemon()
        }
    }
    
    var mainView: some View {
        VStack(spacing: 0) {
            title
            typePickerTitle
            typePicker
            ScrollView(showsIndicators: false) {
                favoritePokemonListTitle
                favoritePokemonList
                pokemonListTitle
                pokemonList
            }
            Spacer()
        }
    }
    
    var title: some View {
        Text("Pokemon Explorer")
            .font(.title)
    }
    
    var typePickerTitle: some View {
        Text("Select a pokemon type:")
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical)
    }
    
    var typePicker: some View {
        Picker("Select Type", selection: $viewModel.typeSelection) {
            ForEach(viewModel.pokemonTypes, id: \.self) { type in
                Text("\(type.rawValue.capitalizingFirstLetter())")
            }
        }
    }
    
    var pokemonListTitle: some View {
        Text("Pokemon:")
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
    }
    
    @ViewBuilder
    var pokemonList: some View {
        if !viewModel.loading {
            VStack(alignment: .leading) {
                ForEach(viewModel.pokemon, id:\.self) { pokemon in
                    PokemonDetailsView(viewModel: viewModel.createPokemonDetailsViewModel(name: pokemon.name))
                }
            }
        }
    }
    
    var favoritePokemonListTitle: some View {
        Text("Favorite Pokemon:")
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
    }
    
    var favoritePokemonList: some View {
        VStack(alignment: .leading) {
            ForEach(viewModel.favoritePokemon, id:\.self) { pokemon in
                PokemonDetailsView(viewModel: viewModel.createPokemonDetailsViewModel(name: pokemon.name))
            }
        }
    }
    
    @ViewBuilder
    var loader: some View {
        if viewModel.loading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

