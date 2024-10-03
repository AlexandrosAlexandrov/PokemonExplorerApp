//
//  UserDefaultsUseCase.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import Foundation
import SwiftUI

public struct UserDefaultsUseCase {
    @AppStorage("checkFavorite") var checkFavorite = false
    private let userDefaultsRepo: UserDefaultsRepositoryProtocol
    
    public init(userDefaultsRepo: UserDefaultsRepositoryProtocol) {
        self.userDefaultsRepo = userDefaultsRepo
    }
    
    public func saveFavouritePokemon(pokemon: FavoritePokemon) {
        var favorites = getFavoritePokemon()
        favorites.append(pokemon)
        favorites.sort { $0.name < $1.name }
        
        userDefaultsRepo.save(favorites, withKey: .favouritePokemon)
        checkFavorite.toggle()
    }
    
    public func getFavoritePokemon() -> [FavoritePokemon] {
        userDefaultsRepo.get(key: .favouritePokemon, ofType: [FavoritePokemon].self) ?? []
    }
    
    public func deleteFavoritePokemon(pokemon: FavoritePokemon) {
        var favorites = getFavoritePokemon()
        favorites.removeAll { $0.name == pokemon.name}
        
        userDefaultsRepo.save(favorites, withKey: .favouritePokemon)
        checkFavorite.toggle()
    }
}
