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
    @StateObject var networkMonitor = NetworkMonitor()
    
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
            pokemonLists
            Spacer()
        }
    }
    
    var pokemonLists: some View {
        ScrollView(showsIndicators: false) {
            typePickerTitle
            typePicker
            favoritePokemonListTitle
            favoritePokemonList
            pokemonListTitle
            pokemonSection
        }
    }
    
    var title: some View {
        CustomText(.mainViewTitle)
            .font(.title)
    }
    
    var typePickerTitle: some View {
        CustomText(.typeSelectTitle)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical)
    }
    
    var typePicker: some View {
        Menu {
            ForEach(viewModel.pokemonTypes, id: \.self) { type in
                Button(action: {
                    viewModel.typeSelection = type
                }) {
                    CustomText("\(type.rawValue.capitalizingFirstLetter())")
                }
            }
        } label: {
            CustomText("\(viewModel.typeSelection.rawValue.capitalizingFirstLetter())")
                .foregroundColor(.black)
                .padding(.vertical)
                .padding(.horizontal, 30)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
    }
    
    var pokemonListTitle: some View {
        CustomText(.pokemonListTitle)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
    }
    
    @ViewBuilder
    var pokemonList: some View {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.pokemon, id:\.self) { pokemon in
                    PokemonDetailsView(
                        viewModel: viewModel.createPokemonDetailsViewModel(name: pokemon.name)
                    )
                    .onAppear {
                        if pokemon == viewModel.pokemon[viewModel.pokemon.count - 5] {
                            viewModel.fetchPokemon(paginated: true)
                        }
                    }
                }
                loader
            }
    }
    
    @ViewBuilder
    var pokemonSection: some View {
        if networkMonitor.isNetworkAvailable {
            pokemonList
        } else {
            noInternetError
        }
    }
    
    var favoritePokemonListTitle: some View {
        CustomText(.favPokemonListTitle)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
    }
    
    var favoritePokemonList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.favoritePokemon, id:\.self) { pokemon in
                    PokemonDetailsView(
                        viewModel: viewModel.createPokemonDetailsViewModel(name: pokemon.name)
                    )
                    .frame(width: 250)
                }
            }
        }
    }
    
    @ViewBuilder
    var loader: some View {
        if viewModel.loading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
        }
    }
    
    var noInternetError: some View {
        CustomText(.noInternetError)
            .multilineTextAlignment(.center)
            .frame(maxHeight: .infinity)
            .padding(.top, 40)
    }

}

