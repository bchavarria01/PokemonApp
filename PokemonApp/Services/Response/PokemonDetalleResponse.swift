//
//  PokemonDetalleResponse.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/4/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class PokemonDetalleResponse {
    var base_happiness: Int?
    var capture_rate: Int?
    var color: Color?
    var egg_groups: [EggGroup]?
    var evolution_chain: EvolutionChain?
    var evolves_from_species: EvolvesFromSpecies?
    var flavor_text_entries: [FlavorTextEntry]?
    var form_descriptions: [Any]?
    var forms_switchable: Bool?
    var gender_rate: Int?
    var genera: [Genera]?
    var generation: Generation?
    var growth_rate: GrowthRate?
    var habitat: Habitat?
    var has_gender_differences: Bool?
    var hatch_counter: Int?
    var id: Int?
    var is_baby: Bool?
    var name: String?
    var names: [Name]?
    var order: Int?
    var pal_park_encounters: [PalParkEncounter]?
    var pokedex_numbers: [PokedexNumber]?
    var shape: Shape?
    var varieties: [Variety]?
}

class Habitat{
    var name: String?
    var url: String?
}

class PokedexNumber{
    var entry_number: Int?
    var pokedex: Pokedex?
}

class Pokedex{
    var name: String?
    var url: String?
}

class EvolutionChain{
    var url: String?
}

class Genera{
    var genus: String?
    var language: Language?
}

class Language: Decodable{
    var name: String?
    var url: String?
}

class Color{
    var name: String?
    var url: String?
}

class PalParkEncounter{
    var area: Area?
    var base_score: Int?
    var rate: Int?
}

class Area{
    var name: String?
    var url: String?
}

class Shape{
    var name: String?
    var url: String?
}

class Name: Decodable{
    var language: Language?
    var name: String?
}

class EggGroup{
    var name: String?
    var url: String?
}

class EvolvesFromSpecies{
    var name: String?
    var url: String?
}

class Generation{
    var name: String?
    var url: String?
}

class FlavorTextEntry{
    var flavor_text: String?
    var language: Language?
    var version: Version?
}

class Version{
    var name: String?
    var url: String?
}

class Variety{
    var is_default: Bool?
    var pokemon: Pokemon1?
}

class Pokemon1{
    var name: String?
    var url: String?
}

class GrowthRate{
    var name: String?
    var url: String?
}
