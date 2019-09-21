//
//  PokedexResponse.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/4/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class PokedexResponse {
    var id: Int?
    var locations: [Location]?
    var main_generation: MainGeneration?
    var name: String?
    var names: [Name]?
    var pokedexes: [Pokedexe]?
    var version_groups: [VersionGroup]?
}
class Location {
    var name: String?
    var url: String?
    }
    
class MainGeneration {
    var name: String?
    var url: String?
    }
    
class Pokedexe {
    var name: String?
    var url: String?
}
