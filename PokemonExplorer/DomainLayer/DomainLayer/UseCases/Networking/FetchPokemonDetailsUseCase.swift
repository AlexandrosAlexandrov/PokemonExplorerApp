//
//  FetchPokemonDetailsUseCase.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import Foundation
import Combine

public class FetchPokemonDetailsUseCase {
    private let pokemonRepository: PokemonRepositoryProtocol
    private var cancellableSet: Set<AnyCancellable> = []
    
    public init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }
    
    public func execute(name: String, completion: @escaping (Result<FetchPokemonDetailsResponse, Error>) -> Void) {
        do {
            try pokemonRepository.fetchPokemonDetails(name: name)
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
            print("Error fetching pokemon details: ", error)
        }
    }
}
