//
//  PokemonDetailResponseModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/6/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation

class PokemonDetailResponseModel: Codable {
    let baseHappiness, captureRate: Int?
    let color: PokemonResponse?
    let eggGroups: [PokemonResponse]?
    let evolutionChain: EvolutionChain?
//    let evolvesFromSpecies: [String]?
    let flavorTextEntries: [FlavorTextEntry]?
    let formDescriptions: [String]?
    let formsSwitchable: Bool?
    let genderRate: Int?
    let genera: [Genus]?
    let generation, growthRate, habitat: PokemonResponse?
    let hasGenderDifferences: Bool?
    let hatchCounter, id: Int?
    let isBaby: Bool?
    let name: String?
    let names: [Name]?
    let order: Int?
    let palParkEncounters: [PalParkEncounter]?
    let pokedexNumbers: [PokedexNumber]?
    let shape: PokemonResponse?
    let varieties: [Variety]?

    enum CodingKeys: String, CodingKey {
        case baseHappiness = "base_happiness"
        case captureRate = "capture_rate"
        case color
        case eggGroups = "egg_groups"
        case evolutionChain = "evolution_chain"
        //case evolvesFromSpecies = "evolves_from_species"
        case flavorTextEntries = "flavor_text_entries"
        case formDescriptions = "form_descriptions"
        case formsSwitchable = "forms_switchable"
        case genderRate = "gender_rate"
        case genera, generation
        case growthRate = "growth_rate"
        case habitat
        case hasGenderDifferences = "has_gender_differences"
        case hatchCounter = "hatch_counter"
        case id
        case isBaby = "is_baby"
        case name, names, order
        case palParkEncounters = "pal_park_encounters"
        case pokedexNumbers = "pokedex_numbers"
        case shape, varieties
    }
}

// MARK: - EvolutionChain
class EvolutionChain: Codable {
    let url: String?
}

// MARK: - FlavorTextEntry
class FlavorTextEntry: Codable {
    let flavorText: String?
    let language, version: PokemonResponse?

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }
}

// MARK: - Genus
class Genus: Codable {
    let genus: String?
    let language: PokemonResponse?
}

// MARK: - PalParkEncounter
class PalParkEncounter: Codable {
    let area: PokemonResponse?
    let baseScore, rate: Int?

    enum CodingKeys: String, CodingKey {
        case area
        case baseScore = "base_score"
        case rate
    }
}

// MARK: - PokedexNumber
class PokedexNumber: Codable {
    let entryNumber: Int?
    let pokedex: PokemonResponse?

    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokedex
    }
}

// MARK: - Variety
class Variety: Codable {
    let isDefault: Bool?
    let pokemon: PokemonResponse?

    enum CodingKeys: String, CodingKey {
        case isDefault = "is_default"
        case pokemon
    }
}
