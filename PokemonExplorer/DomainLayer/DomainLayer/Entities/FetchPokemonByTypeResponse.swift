//
//  FetchPokemonByTypeResponse.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 27/9/24.
//

import Foundation

public struct FetchPokemonByTypeResponse: Codable {
    public let pokemon: [Pokemon]?
    
    public func convertToPokemonResultArray() -> [PokemonResult] {
        var pokemonResult: [PokemonResult] = []
        for indice in pokemon ?? [] {
            let details = PokemonResult(name: indice.pokemon?.name)
            pokemonResult.append(details)
        }
        
        return pokemonResult
    }
}

public struct Pokemon: Codable {
    public let pokemon: PokemonDetails?
}

public struct PokemonDetails: Codable {
    public let name: String?
}
