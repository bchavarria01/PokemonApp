//
//  RegionsViewModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/5/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class RegionsViewModel {
    // MARK: - Services
    
    let pokemonService: PokemonServices
    
    // MARK: - LifeCycle
    
    init(pokemonService: PokemonServices) {
        self.pokemonService = pokemonService
    }
    
    func getRegions() -> Single<RegionsResponseModel> {
        return pokemonService.getRegions().asObservable().asSingle()
    }
}
