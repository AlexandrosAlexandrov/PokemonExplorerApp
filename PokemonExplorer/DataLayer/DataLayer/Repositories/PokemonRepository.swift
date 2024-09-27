//
//  PokemonRepository.swift
//  DataLayer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import Foundation
import DomainLayer
import Alamofire
import Combine

public struct PokemonRepository: PokemonRepositoryProtocol {
    
    public init() {}
    
    public func fetchAllPokemon(itemCount: Int) throws -> AnyPublisher<DataResponse<FetchAllPokemonResponse, BaseNetworkError>, Never> {
        let urlRequest = try PokemonRequestBuilder.fetchAllPokemon(itemCount: itemCount).asURLRequest()
        
        return ApiClient.requestCodable(urlRequest)
    }
    
    public func fetchPokemonDetails(name: String) throws -> AnyPublisher<DataResponse<FetchPokemonDetailsResponse, BaseNetworkError>, Never> {
        let urlRequest = try PokemonRequestBuilder.fetchPokemonDetails(name: name).asURLRequest()
        
        return ApiClient.requestCodable(urlRequest)
    }
    
    public func fetchPokemonByType(type: PokemonType) throws -> AnyPublisher<DataResponse<FetchPokemonByTypeResponse, BaseNetworkError>, Never> {
        let urlRequest = try PokemonRequestBuilder.fetchPokemonByType(type: type).asURLRequest()
        
        return ApiClient.requestCodable(urlRequest)
    }
}
