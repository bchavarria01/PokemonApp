//
//  EquipoResponse.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/4/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class EquipoResponse {
    var id: String?
    var idRegion: String?
    var nombre: String?
    var pokemon: [Pokemon]?
}

class Pokemon {
    var id: String?
    var numero: String?
    var nombre: String?
    var imagen: String?
    var tipo: String?
    var region: String?
    var descripcion: String?
}
