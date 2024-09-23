//
//  UserDefaultsRepositoryProtocol.swift
//  DomainLayer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import Foundation

public protocol UserDefaultsRepositoryProtocol{
    //MARK: Key
    func get<T: Codable>(key: UserDefaults.Key, ofType type: T.Type) -> T?
    func save<T: Codable>(_ value: T, withKey key: UserDefaults.Key)
    func delete(forKey key: UserDefaults.Key)
    //MARK: String
    func get<T: Codable>(key: String, ofType type: T.Type) -> T?
    func save<T: Codable>(_ value: T, withKey key: String)
    func delete(forKey key: String)
}
