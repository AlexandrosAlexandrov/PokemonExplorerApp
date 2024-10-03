//
//  PokemonListViewModel.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import Foundation
import DomainLayer
import SwiftUI

class PokemonListViewModel: ObservableObject {
    @Published var pokemon = [PokemonResult]()
    @Published var favoritePokemon = [FavoritePokemon]()
    @Published var pokemonTypes = PokemonType.allCases
    @Published var typeSelection = PokemonType.all
    
    @Published var favoriteToggle = false
    @Published var loading = false
    
    @Inject var fetchAllPokemonUseCase: FetchAllPokemonUseCase?
    @Inject var fetchPokemonByTypeUseCase: FetchPokemonByTypeUseCase?
    @Inject var userDefaultsUseCase: UserDefaultsUseCase?
    
    init() {
        fetchAllPokemon()
        fetchFavoritePokemon()
    }
    
    private func fetchAllPokemon() {
        loading = true
        fetchAllPokemonUseCase?.execute(itemCount: 151, completion: { result in
            switch result {
            case .success(let pokemonResponse):
                print("Success!")
                self.pokemon = pokemonResponse.results ?? []
            case .failure(let error):
                print("Failure :( ", error)
            }
            
            self.loading = false
        })
    }
    
    private func fetchPokemonByType(type: PokemonType) {
        loading = true
        fetchPokemonByTypeUseCase?.execute(type: type, completion: { result in
            switch result {
            case .success(let pokemonResponse):
                print("Success!")
                self.pokemon = pokemonResponse.convertToPokemonResultArray()
            case .failure(let error):
                print("Failure :( ", error)
            }
            
            self.loading = false
        })
    }
    
    public func createPokemonDetailsViewModel(name: String?) -> PokemonDetailsViewModel {
        PokemonDetailsViewModel(delegate: self, name: name ?? "")
    }
    
    public func fetchFavoritePokemon() {
        self.favoritePokemon = userDefaultsUseCase?.getFavoritePokemon() ?? []
    }
    
    public func fetchPokemon() {
        switch typeSelection {
        case .all:
            self.fetchAllPokemon()
        default:
            self.fetchPokemonByType(type: typeSelection)
        }
    }
}

extension PokemonListViewModel: PokemonDetailsViewModelDelegate {
    func toggledFavorite() {
        withAnimation {
            fetchFavoritePokemon()
            favoriteToggle.toggle()
        }
    }
    
}
