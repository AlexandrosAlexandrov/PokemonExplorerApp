//
//  UserDefaultsRepository.swift
//  DataLayer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import Foundation
import DomainLayer

public struct UserDefaultsRepositoryImpl: UserDefaultsRepositoryProtocol {
    let defaults: UserDefaults
    
    public init() {
        self.defaults = .standard
    }
    
    //MARK: key as Key
    public func get<T>(key: UserDefaults.Key, ofType type: T.Type) -> T? where T : Decodable, T : Encodable {
        guard let data = defaults.object(forKey: key.rawValue) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(type, from: data)
    }
    
    public func save<T>(_ value: T, withKey key: UserDefaults.Key) where T : Decodable, T : Encodable {
        if let encodedValue = try? JSONEncoder().encode(value) {
            defaults.set(encodedValue, forKey: key.rawValue)
        }
    }
    
    public func delete(forKey key: UserDefaults.Key) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    //MARK: key as String
    public func get<T>(key: String, ofType type: T.Type) -> T? where T : Decodable, T : Encodable {
        guard let data = defaults.object(forKey: key) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(type, from: data)
    }
    
    public func save<T>(_ value: T, withKey key: String) where T : Decodable, T : Encodable {
        if let encodedValue = try? JSONEncoder().encode(value) {
            defaults.set(encodedValue, forKey: key)
        }
    }
    
    public func delete(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
}
