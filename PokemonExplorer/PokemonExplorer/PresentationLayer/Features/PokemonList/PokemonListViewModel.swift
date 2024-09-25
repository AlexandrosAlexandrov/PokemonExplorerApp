//
//  PokemonListViewModel.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import Foundation
import DomainLayer

class PokemonListViewModel: ObservableObject {
    @Published var pokemon: [PokemonResult] = []
    
    @Inject var fetchAllPokemonUseCase: FetchAllPokemonUseCase?
    
    init() {
        fetchAllPokemon()
    }
    
    private func fetchAllPokemon() {
        fetchAllPokemonUseCase?.execute(itemCount: 151, completion: { result in
            switch result {
            case .success(let pokemonResponse):
                print("Success!")
                self.pokemon = pokemonResponse.results ?? []
            case .failure(let error):
                print("Failure :( ", error)
            }
        })
    }
}
