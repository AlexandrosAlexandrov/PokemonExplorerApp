//
//  AppAssembler.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import Swinject
import DomainLayer
import DataLayer

class AppAssembler: ObservableObject {
    let mainAppContainer: Container
    
    init() {
        self.mainAppContainer = Resolver.shared.getContainer()
        self.registerAppDependencies()
    }
    
    private func registerAppDependencies() {
        //User Defaults
        registerUserDefaultsRepoDependencies()
        registerUserDefaultsUseCaseDepdencies()
    }
    
    private func registerUserDefaultsRepoDependencies() {
        mainAppContainer.register(UserDefaultsRepositoryProtocol.self) { _ in
            UserDefaultsRepositoryImpl()
        }
    }
    
    private func registerUserDefaultsUseCaseDepdencies() {
        mainAppContainer.register(UserDefaultsUseCase.self) { r in
            let userDefaultsRepo = r.resolve(UserDefaultsRepositoryProtocol.self)!
            return UserDefaultsUseCase(userDefaultsRepo: userDefaultsRepo)
        }
    }
}
