//
//  PokemonResponse.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/6/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation

final class PokemonResponse: Decodable {
    let name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}
