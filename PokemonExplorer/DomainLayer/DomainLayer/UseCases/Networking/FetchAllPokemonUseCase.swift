//
//  FetchAllPokemonUseCase.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import Foundation
import Combine

public class FetchAllPokemonUseCase {
    private let pokemonRepository: PokemonRepositoryProtocol
    private var cancellableSet: Set<AnyCancellable> = []
    
    public init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }
    
    public func execute(itemCount: Int, completion: @escaping (Result<FetchAllPokemonResponse, Error>) -> Void) {
        do {
            try pokemonRepository.fetchAllPokemon(itemCount: itemCount)
                .sink { dataResponse in
                    if let error = dataResponse.error {
                        completion(.failure(error))
                    } else if let pokemonResponse = dataResponse.value {
                        completion(.success(pokemonResponse))
                    } else {
                        completion(.failure(GenericError.runtimeError("Oops! Something went wrong.")))
                    }
                }.store(in: &cancellableSet)
        }
        catch {
            print("Error fetching all pokemon: ", error)
        }
    }
}
