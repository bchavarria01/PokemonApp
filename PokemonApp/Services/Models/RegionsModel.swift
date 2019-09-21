//
//  RegionsModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/4/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class RegionsModel {
    var count: Int?
    var next: Any?
    var previous: Any?
    var results: [Result1]?
}

class Result1 {
    var name: String?
    var url: String?
}
