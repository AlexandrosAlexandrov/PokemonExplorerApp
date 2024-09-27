//
//  FetchAllPokemonResponse.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import Foundation

public struct FetchAllPokemonResponse: Codable {
    public let results: [PokemonResult]?
}

public struct PokemonResult: Codable, Hashable {
    public let name: String?
    
    public init(name: String?) {
        self.name = name
    }
}
