//
//  PokemonsViewModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/5/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import RxSwift
import RxCocoa

final class PokemonsViewModel {
    // MARK: - Services
    
    let pokemonService: PokemonServices
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    init(pokemonService: PokemonServices) {
        self.pokemonService = pokemonService
    }
    
    func getPokemonsPerRegion(regionsUrl: String) -> Single<RegionsInfoResponseModel> {
        let url = URL(string: regionsUrl)!
        return pokemonService.getRegionsInfo(regionUrl: url)
            .asObservable()
            .map { $0 }
            .asSingle()
    }
    
    func getPokedexInfop(pokedexUrl: String) -> Single<PokedexResponseModel> {
        let url = URL(string: pokedexUrl)!
        return pokemonService.getPokedex(pokedexUrl: url)
            .asObservable()
            .map { $0 }
            .asSingle()
    }
}
