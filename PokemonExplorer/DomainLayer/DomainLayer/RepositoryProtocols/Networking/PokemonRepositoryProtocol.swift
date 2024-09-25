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
}
