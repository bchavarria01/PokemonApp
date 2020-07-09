//
//  PokedexResponseModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/5/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation

// MARK: - PokedexResponseModel
struct PokedexResponseModel: Codable {
    let descriptions: [Description]?
    let id: Int?
    let isMainSeries: Bool?
    let name: String?
    let names: [Name]?
    let pokemonEntries: [PokemonEntry]?
    let region: PokemonResponse?
    let versionGroups: [PokemonResponse]?

    enum CodingKeys: String, CodingKey {
        case descriptions, id
        case isMainSeries = "is_main_series"
        case name, names
        case pokemonEntries = "pokemon_entries"
        case region
        case versionGroups = "version_groups"
    }
}

// MARK: - Description
struct Description: Codable {
    let descriptionDescription: String?
    let language: PokemonResponse?

    enum CodingKeys: String, CodingKey {
        case descriptionDescription = "description"
        case language
    }
}

// MARK: - PokemonEntry
struct PokemonEntry: Codable {
    let entryNumber: Int?
    let pokemonSpecies: PokemonResponse?

    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokemonSpecies = "pokemon_species"
    }
}

