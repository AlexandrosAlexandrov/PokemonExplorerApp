//
//  PokemonDetailsView.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import SwiftUI
import Kingfisher

struct PokemonDetailsView: View {
    @StateObject var viewModel: PokemonDetailsViewModel
    @AppStorage("checkFavorite") var checkFavorite = false
    
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
        .background(.bgBlue)
        .onChange(of: checkFavorite) { _, _ in
            viewModel.checkIfPokemonFavorite()
        }
        
    }
    
    @ViewBuilder
    var sprite: some View {
        if viewModel.isFavorite {
            Image(uiImage: ImageSaver.getSavedImage(for: viewModel.name)!)
        } else {
            KFImage(URL(string: viewModel.pokemonDetails?.sprites?.defaultSprite ?? ""))
        }
    }
    
    var pokeName: some View {
        HStack {
            Text(viewModel.name.capitalizingFirstLetter())
                .font(.title3)
            
            Spacer()
            
            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.top, 5)
                .onTapGesture {
                    viewModel.toggleFavorite()
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
