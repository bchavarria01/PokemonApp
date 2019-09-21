//
//  CampoSimple.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/6/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Foundation
import UIKit

class CampoSimple: Decodable, Encodable {
    var etiqueta: String?
    var valor: String?
    var longitud: Int = 1
    var tipo: TipoCampo = .texto
    var agenda: Bool = false
    init() {
        //constructor
    }
    init(etiqueta: String, valor: String, longitud: Int, tipo: TipoCampo, agenda: Bool) {
        self.etiqueta = etiqueta
        self.valor = valor
        self.longitud = longitud
        self.tipo = tipo
        self.agenda = agenda
    }
}

enum TipoCampo: String, Codable {
    case numero = "N"
    case texto = "A"
    case agenda = "AG"
    case slider = "S"
    case check = "C"
    case modal = "M"
}
