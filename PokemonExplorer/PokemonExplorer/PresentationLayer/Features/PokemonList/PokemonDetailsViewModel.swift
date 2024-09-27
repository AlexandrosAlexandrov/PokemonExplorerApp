//
//  PokemonDetailsViewModel.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import Foundation
import DomainLayer

class PokemonDetailsViewModel: ObservableObject {
    @Published var pokemonDetails: FetchPokemonDetailsResponse?
    @Published var loading = false
    
    @Inject var fetchPokemonDetailsUseCase: FetchPokemonDetailsUseCase?
    
    init() {}
    
    public func fetchPokemonDetails(name: String) {
        loading = true
        fetchPokemonDetailsUseCase?.execute(name: name, completion: { result in
            switch result {
            case .success(let pokemonResponse):
                print("Success getting details!")
                self.pokemonDetails = pokemonResponse
            case .failure(let error):
                print("Failure getting details :( ", error)
            }
            
            self.loading = false
        })
    }
    
    public func getPokemonStat(_ pokemonStat: PokemonStat) -> Int {
        for stat in pokemonDetails?.stats ?? [] {
            if stat.statDetails?.name == pokemonStat.rawValue {
                return stat.base ?? 0
            }
        }
        
        return 0
    }
}
