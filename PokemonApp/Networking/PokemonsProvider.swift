//
//  PokemonsProvider.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/5/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Moya

enum PokemonsProvider {
    case getPokemonsRegions
    case getRegionsInfo(regionUrl: URL)
    case getPokedex(pokedexUrl: URL)
    case getPokemonDetail
}

extension PokemonsProvider: TargetType {
    var path: String {
        return ""
    }
    
    var baseURL: URL {
        switch self {
        case .getPokemonsRegions:
            return K.PokemonServices.region
            
        case let .getPokedex(pokedexUrl):
            return pokedexUrl
            
        case let .getRegionsInfo(regionUrl):
            return regionUrl
            
        case .getPokemonDetail:
            return K.PokemonServices.pokedex
        }
    }
    
    var method: Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return K.MoyaDefaults.defaultHeaders
    }
}
