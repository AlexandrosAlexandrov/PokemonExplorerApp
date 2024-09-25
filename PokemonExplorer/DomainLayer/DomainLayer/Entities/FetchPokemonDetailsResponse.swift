//
//  FetchPokemonDetailsResponse.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import Foundation

public struct FetchPokemonDetailsResponse: Codable {
    public let sprites: Sprites?
    public let stats: [Stat]?
}

public struct Sprites: Codable {
    public let defaultSprite: String?
    
    enum CodingKeys: String, CodingKey {
        case defaultSprite = "front_default"
    }
}

public struct Stat: Codable {
    public let base: Int?
    public let statDetails: StatDetails?
    
    enum CodingKeys: String, CodingKey {
        case base = "base_stat"
        case statDetails = "stat"
    }
}

public struct StatDetails: Codable {
    public let name: String?
}
