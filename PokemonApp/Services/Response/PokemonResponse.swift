//
//  PokemonResponse.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/3/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class PokemonResponse: Decodable {
    var descriptions: [Description]?
    var id: Int?
    var is_main_series: Bool?
    var name: String?
    var names: [Name]?
    var pokemon_entries: [PokemonEntry]?
    var region: Region?
    var version_groups: [VersionGroup]?
}

class Region: Decodable {
    var name: String?
    var url: String?
}

class PokemonEntry: Decodable {
    var entry_number: Int?
    var pokemon_species: PokemonSpecies?
}

class PokemonSpecies: Decodable {
    var name: String?
    var url: String?
}

class Description: Decodable {
    var description: String?
    var language: Language?
}

class VersionGroup: Decodable {
    var name: String?
    var url: String?
}
