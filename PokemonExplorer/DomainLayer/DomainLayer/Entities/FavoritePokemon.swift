//
//  FavoritePokemon.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 1/10/24.
//

import Foundation

public struct FavoritePokemon: Codable, Hashable {
    public let name: String
    public let hp: Int
    public let attack: Int
    public let defense: Int
    
    public init(
        name: String,
        hp: Int,
        attack: Int,
        defense: Int
    ) {
        self.name = name
        self.hp = hp
        self.attack = attack
        self.defense = defense
    }
}
