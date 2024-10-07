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
            pokeDetails
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
    
    var pokeDetails: some View {
        VStack(alignment: .leading) {
            pokeHeader
            pokeStats
        }
        
    }
    
    @ViewBuilder
    var sprite: some View {
        if viewModel.isFavorite {
            savedImage
        } else {
            imageFromUrl
        }
    }
    
    var savedImage: some View {
        Image(uiImage: ImageSaver.getSavedImage(for: viewModel.name)!)
    }
    
    var imageFromUrl: some View {
        KFImage(URL(string: viewModel.pokemonDetails?.sprites?.defaultSprite ?? ""))
            .placeholder({ _ in
                loader
            })
    }
    
    var pokeHeader: some View {
        HStack {
            pokeName
            Spacer()
            favoriteButton
        }
        .padding(.horizontal, 8)
    }
    
    var pokeName: some View {
        Text(viewModel.name.capitalizingFirstLetter())
            .font(.title3)
    }
    
    var favoriteButton: some View {
        Image(systemName: viewModel.isFavorite ? Icons.liked.rawValue : Icons.unliked.rawValue)
            .resizable()
            .foregroundColor(.heartRed)
            .frame(width: 30, height: 30)
            .padding(.top, 10)
            .padding(.leading, 5)
            .onTapGesture {
                viewModel.toggleFavorite()
            }
    }
    
    var pokeStats: some View {
        HStack(spacing: 16) {
            sprite
            statsList
        }
    }
    
    var statsList: some View {
        VStack(alignment: .leading) {
            CustomText(Strings.hp.rawValue + "\(viewModel.getPokemonStat(.hp))")
            CustomText(Strings.attack.rawValue + "\(viewModel.getPokemonStat(.attack))")
            CustomText(Strings.defense.rawValue + "\(viewModel.getPokemonStat(.defense))")
        }
    }
    
    @ViewBuilder
    var loader: some View {
        if viewModel.loading {
            ProgressView()
        }
    }
}
