//
//  PokemonDetailsViewModel.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import Foundation
import DomainLayer

protocol PokemonDetailsViewModelDelegate {
    func toggledFavorite()
}

class PokemonDetailsViewModel: ObservableObject {
    @Published var name: String
    @Published var pokemonDetails: FetchPokemonDetailsResponse?
    @Published var loading = false
    @Published var isFavorite = false
    
    @Inject var fetchPokemonDetailsUseCase: FetchPokemonDetailsUseCase?
    @Inject var userDefaultsUseCase: UserDefaultsUseCase?
    
    private var delegate: PokemonDetailsViewModelDelegate?
    
    init(delegate: PokemonDetailsViewModelDelegate?, name: String) {
        self.delegate = delegate
        self.name = name
        self.checkIfPokemonFavorite()
        self.fetchPokemonDetails()
    }
    
    public func fetchPokemonDetails() {
        loading = !isFavorite
        fetchPokemonDetailsUseCase?.execute(name: name, completion: { result in
            switch result {
            case .success(let pokemonResponse):
                print("Success getting details!")
                self.pokemonDetails = pokemonResponse
                ImageSaver.downloadAndSaveImage(for: self.name, from: pokemonResponse.sprites?.defaultSprite ?? "") { _ in
                    
                }
            case .failure(let error):
                print("Failure getting details :( ", error)
            }
            
            self.loading = false
        })
    }
    
    public func checkIfPokemonFavorite() {
        self.isFavorite = false
        let favPokemon = userDefaultsUseCase?.getFavoritePokemon()
        
        for pokemon in favPokemon ?? [] {
            if pokemon.name == name {
                self.isFavorite = true
                print("\(name) is favorite")
            }
        }
    }
    
    public func getPokemonStat(_ pokemonStat: PokemonStat) -> Int {
        if isFavorite {
            return getFavoritePokemonStat(pokemonStat)
        }
        
        for stat in pokemonDetails?.stats ?? [] {
            if stat.statDetails?.name == pokemonStat.rawValue {
                return stat.base ?? 0
            }
        }
        
        return 0
    }
    
    public func getFavoritePokemonStat(_ pokemonStat: PokemonStat) -> Int {
        let favPokemon = userDefaultsUseCase?.getFavoritePokemon()
        
        for pokemon in favPokemon ?? [] {
            if pokemon.name == name {
                switch pokemonStat {
                case .hp:
                    return pokemon.hp
                case .attack:
                    return pokemon.attack
                case .defense:
                    return pokemon.defense
                }
            }
        }
        
        return 0
    }
    
    public func toggleFavorite() {
        switch isFavorite {
        case true:
            deletePokemonFromFavorites()
        case false:
            savePokemonToFavorites()
        }
        
        delegate?.toggledFavorite()
    }
    
    public func savePokemonToFavorites() {
        let favPokemon = FavoritePokemon(
            name: name,
            hp: getPokemonStat(.hp),
            attack: getPokemonStat(.attack),
            defense: getPokemonStat(.defense)
        )
        
        userDefaultsUseCase?.saveFavouritePokemon(pokemon: favPokemon)
        self.isFavorite = true
    }
    
    public func deletePokemonFromFavorites() {
        let favPokemon = FavoritePokemon(
            name: name,
            hp: getPokemonStat(.hp),
            attack: getPokemonStat(.attack),
            defense: getPokemonStat(.defense)
        )
        
        userDefaultsUseCase?.deleteFavoritePokemon(pokemon: favPokemon)
        self.isFavorite = false
    }
    
}
