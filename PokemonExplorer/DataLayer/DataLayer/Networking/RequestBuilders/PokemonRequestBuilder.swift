//
//  PokemonRequestBuilder.swift
//  DataLayer
//
//  Created by Alexandros Alexandrov on 25/9/24.
//

import Foundation
import Alamofire
import DomainLayer

public enum PokemonRequestBuilder: URLRequestConvertible {
    
    //MARK: - URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.pokemonBaseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    case fetchAllPokemon(itemCount: Int)
    case fetchPokemonDetails(name: String)
    case fetchPokemonByType(type: PokemonType)
    
    
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
        switch self {
        case .fetchAllPokemon, .fetchPokemonDetails, .fetchPokemonByType:
            return .get
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    private var path: String {
        switch self {
        case .fetchAllPokemon:
            return "pokemon"
        case .fetchPokemonDetails(let name):
            return "pokemon/\(name)"
        case .fetchPokemonByType(let type):
            return "type/\(type.rawValue)"
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    private var parameters: Parameters? {
        switch self {
        case .fetchAllPokemon(let itemCount):
            return [
                "limit": itemCount
            ]
        default:
            return nil
        }
    }
}
