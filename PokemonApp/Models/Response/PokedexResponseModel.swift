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
    let names: [Name1]?
    let pokemonEntries: [PokemonEntry]?
    let region: Region?
    let versionGroups: [Region]?

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
    let language: Region?

    enum CodingKeys: String, CodingKey {
        case descriptionDescription = "description"
        case language
    }
}

// MARK: - Region
struct Region: Codable {
    let name: String?
    let url: String?
}

// MARK: - Name
struct Name1: Codable {
    let language: Region?
    let name: String?
}

// MARK: - PokemonEntry
struct PokemonEntry: Codable {
    let entryNumber: Int?
    let pokemonSpecies: Region?

    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokemonSpecies = "pokemon_species"
    }
}

