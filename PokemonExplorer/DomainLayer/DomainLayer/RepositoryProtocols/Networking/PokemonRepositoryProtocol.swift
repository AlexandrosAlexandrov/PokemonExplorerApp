//
//  PokemonRepositoryProtocol.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import Foundation
import Combine
import Alamofire

public protocol PokemonRepositoryProtocol {
    func fetchAllPokemon(itemCount: Int) throws -> AnyPublisher<DataResponse<FetchAllPokemonResponse, BaseNetworkError>, Never>
    func fetchPokemonDetails(name: String) throws -> AnyPublisher<DataResponse<FetchPokemonDetailsResponse, BaseNetworkError>, Never>
    func fetchPokemonByType(type: PokemonType) throws -> AnyPublisher<DataResponse<FetchPokemonByTypeResponse, BaseNetworkError>, Never>
}
