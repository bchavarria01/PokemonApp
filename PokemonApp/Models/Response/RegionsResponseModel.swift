//
//  RegionsResponseModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/5/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation

// MARK: - RegionsResponse
struct RegionsResponseModel: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let regions: [Regions]?

    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case regions = "results"
    }
}

// MARK: - Result
struct Regions: Decodable {
    let name: String?
    let url: String?

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}

