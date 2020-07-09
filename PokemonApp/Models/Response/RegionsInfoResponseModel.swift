//
//  RegionsInfoResponseModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/5/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation

struct RegionsInfoResponseModel: Codable {
    let id: Int?
    let locations: [PokemonResponse]?
    let mainGeneration: PokemonResponse?
    let name: String?
    let names: [Name]?
    let pokedexes, versionGroups: [PokemonResponse]?

    enum CodingKeys: String, CodingKey {
        case id, locations
        case mainGeneration = "main_generation"
        case name, names, pokedexes
        case versionGroups = "version_groups"
    }
}

// MARK: - Name
struct Name: Codable {
    let language: PokemonResponse?
    let name: String?
}
