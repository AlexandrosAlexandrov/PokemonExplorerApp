//
//  FetchPokemonByTypeUseCase.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 27/9/24.
//

import Foundation
import Combine

public class FetchPokemonByTypeUseCase {
    private let pokemonRepository: PokemonRepositoryProtocol
    private var cancellableSet: Set<AnyCancellable> = []
    
    public init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }
    
    public func execute(type: PokemonType, completion: @escaping (Result<FetchPokemonByTypeResponse, Error>) -> Void) {
        do {
            try pokemonRepository.fetchPokemonByType(type: type)
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
            print("Error fetching pokemon by type: ", error)
        }
    }
}
