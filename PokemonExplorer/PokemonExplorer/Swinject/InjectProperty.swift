//
//  InjectProperty.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import Foundation
import Swinject
import SwiftUI


@propertyWrapper
struct Inject<I> {
    public var wrappedValue: I?
    
    public init(named: String? = nil) {
        self.wrappedValue = Resolver.shared.resolve(I.self, named)
    }
    
    public init(wrappedValue: I?) {
        self.wrappedValue = wrappedValue
    }
}
