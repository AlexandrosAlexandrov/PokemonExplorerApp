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
    @Published var page = 2
    @Published var lastYOffset: CGFloat?
    
    @Inject var fetchAllPokemonUseCase: FetchAllPokemonUseCase?
    @Inject var fetchPokemonByTypeUseCase: FetchPokemonByTypeUseCase?
    @Inject var userDefaultsUseCase: UserDefaultsUseCase?
    
    private let itemCount = 30
    
    init() {
        fetchAllPokemon()
        fetchFavoritePokemon()
    }
    
    private func fetchAllPokemon(paginated: Bool = false) {
        loading = true
        fetchAllPokemonUseCase?.execute(itemCount: itemCount, page: paginated ? page : 1, completion: { result in
            switch result {
            case .success(let pokemonResponse):
                if paginated {
                    self.pokemon += pokemonResponse.results ?? []
                    self.page += 1
                } else {
                    self.pokemon = pokemonResponse.results ?? []
                }
            case .failure(let error):
                print("Failure :( ", error)
            }
            
            self.loading = false
        })
    }
    
    private func fetchPokemonByType(type: PokemonType) {
        page = 2
        loading = true
        fetchPokemonByTypeUseCase?.execute(type: type, completion: { result in
            switch result {
            case .success(let pokemonResponse):
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
    
    public func fetchPokemon(paginated: Bool = false) {
        switch typeSelection {
        case .all:
            self.fetchAllPokemon(paginated: paginated)
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
