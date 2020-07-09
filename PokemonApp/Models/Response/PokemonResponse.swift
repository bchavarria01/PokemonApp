//
//  PokemonResponse.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/6/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation

struct PokemonResponse: Codable {
    let name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
