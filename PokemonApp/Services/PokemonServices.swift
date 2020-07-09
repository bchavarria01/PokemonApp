//
//  PokemonServices.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/29/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Moya
import RxSwift

final class PokemonServices {
    
    // MARK: - ProvidMoers
    
    private let provider = MoyaProvider<PokemonsProvider>(
        plugins: K.MoyaDefaults.plugins
    )
    
    // MARK: - Regions
    
    func getRegions() -> Single<RegionsResponseModel> {
        return provider.rx
            .request(.getPokemonsRegions)
            .filterSuccessfulStatusCodes()
            .map(RegionsResponseModel.self)
            .asObservable()
            .asSingle()
    }
    
    func getRegionsInfo(regionUrl: URL) -> Single<RegionsInfoResponseModel> {
        return provider.rx
            .request(.getRegionsInfo(regionUrl: regionUrl))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(RegionsInfoResponseModel.self)
            .asObservable()
            .asSingle()
    }
    
    func getPokedex(pokedexUrl: URL) -> Single<PokedexResponseModel> {
        return provider.rx
            .request(.getPokedex(pokedexUrl: pokedexUrl))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(PokedexResponseModel.self)
            .asObservable()
            .asSingle()
    }
    
    func getPokemonDetail(pokemonUrl: URL) -> Single<PokemonDetailResponseModel> {
        return provider.rx
            .request(.getPokemonDetail(pokemonUrl: pokemonUrl))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(PokemonDetailResponseModel.self)
            .asObservable()
            .asSingle()
    }
    
    func getHabitatInformation(habitatUrl: URL) -> Single<HabitatResponseModel> {
        return provider.rx
            .request(.getHabitatInformation(habitatUrl: habitatUrl))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(HabitatResponseModel.self)
            .asObservable()
            .asSingle()
    }
    
}
