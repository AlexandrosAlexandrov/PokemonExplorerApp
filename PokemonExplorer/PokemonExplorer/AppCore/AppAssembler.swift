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
        
        //Pokemon API
        registerPokemonRepoDependencies()
        registerFetchAllPokemonUseCaseDependencies()
        registerFetchPokemonDetailsUseCaseDependencies()
        registerFetchPokemonByTypeUseCaseDependencies()
        
    }
    
    private func registerUserDefaultsRepoDependencies() {
        mainAppContainer.register(UserDefaultsRepositoryProtocol.self) { _ in
            UserDefaultsRepositoryImpl()
        }
    }
    
    private func registerPokemonRepoDependencies() {
        mainAppContainer.register(PokemonRepositoryProtocol.self) { _ in
            PokemonRepository()
        }
    }
    
    private func registerUserDefaultsUseCaseDepdencies() {
        mainAppContainer.register(UserDefaultsUseCase.self) { r in
            let userDefaultsRepo = r.resolve(UserDefaultsRepositoryProtocol.self)!
            return UserDefaultsUseCase(userDefaultsRepo: userDefaultsRepo)
        }
    }
    
    private func registerFetchAllPokemonUseCaseDependencies() {
        mainAppContainer.register(FetchAllPokemonUseCase.self) { r in
            let pokemonRepo = r.resolve(PokemonRepositoryProtocol.self)!
            return FetchAllPokemonUseCase(pokemonRepository: pokemonRepo)
        }
    }
    
    private func registerFetchPokemonDetailsUseCaseDependencies() {
        mainAppContainer.register(FetchPokemonDetailsUseCase.self) { r in
            let pokemonRepo = r.resolve(PokemonRepositoryProtocol.self)!
            return FetchPokemonDetailsUseCase(pokemonRepository: pokemonRepo)
        }
    }
    
    private func registerFetchPokemonByTypeUseCaseDependencies() {
        mainAppContainer.register(FetchPokemonByTypeUseCase.self) { r in
            let pokemonRepo = r.resolve(PokemonRepositoryProtocol.self)!
            return FetchPokemonByTypeUseCase(pokemonRepository: pokemonRepo)
        }
    }

}
