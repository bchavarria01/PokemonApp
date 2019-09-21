//
//  RegionResponse.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/4/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class RegionResponse {
    var count: Int?
    var next: Any?
    var previous: Any?
    var results: [Result]?
}

class Result {
    var name: String?
    var url: String?
}
