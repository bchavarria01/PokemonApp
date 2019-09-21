//
//  BaseRequest.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/3/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Foundation

class BaseRequest: Encodable {
    var token: String?
    private enum CodingKeys: String, CodingKey {
        case token = "Token"
    }
    
}

class CryptoRequest: Encodable {
    var data: String?
}
