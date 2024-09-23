//
//  UserDefaultsUseCase.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import Foundation

public struct UserDefaultsUseCase {
    private let userDefaultsRepo: UserDefaultsRepositoryProtocol
    
    public init(userDefaultsRepo: UserDefaultsRepositoryProtocol) {
        self.userDefaultsRepo = userDefaultsRepo
    }
    
    public func saveFavouritePokemon() {
        
    }
}
