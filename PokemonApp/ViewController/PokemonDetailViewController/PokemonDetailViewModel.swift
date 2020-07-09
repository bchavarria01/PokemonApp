//
//  PokemonDetailViewModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/8/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import RxSwift

final class PokemonDetailViewModel {
    
    // MARK: - Attributes
    
    var pokemonService: PokemonServices
    
    // MARK: - LifeCycle
    
    init(pokemonService: PokemonServices) {
        self.pokemonService = pokemonService
    }
    
    // MARK: - Helpers
    
    func getPokemonDetail(with pokemonUrl: String) -> Single<PokemonDetailResponseModel> {
        let url: URL = URL(string: pokemonUrl)!
        return pokemonService.getPokemonDetail(pokemonUrl: url)
                .asObservable()
                .map { $0 }
                .asSingle()
    }
    
    func getHabitatInformation(with habitatUrl: String) -> Single<HabitatResponseModel> {
        let url: URL = URL(string: habitatUrl)!
        return pokemonService.getHabitatInformation(habitatUrl: url)
                .asObservable()
                .map { $0 }
                .asSingle()
    }
    
}
