//
//  HabitatResponseModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/8/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation

struct HabitatResponseModel: Codable {
    let id: Int?
    let name: String?
    let names: [Name]?
    let pokemonSpecies: [PokemonResponse]?

    enum CodingKeys: String, CodingKey {
        case id, name, names
        case pokemonSpecies = "pokemon_species"
    }
}
