//
//  AtributoColector.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/6/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class AtributoColector: Decodable, Encodable {
    var codigo: String?
    var etiqueta: String?
    var obligatorio: String?
    var bobligatorio: Bool = false
    var iorden: Int = 0
    var orden: String?
    var llongitud: Int = 1
    var longitud: String?
    var tipo: TipAtributo = .texto
    var valor: String?
    var bvisible: Bool = true
    var visible: String?
    var funcion: String?
    var ddecimales: Int = 0
    var decimales: String?
    var formatoFecha: String?
    var camara: Bool = false
    var habilitado = true
    var campoExtra = false
    var enLinea = false
    var placeHolder = ""
    private enum CodingKeys: String, CodingKey {
        case codigo = "CodigoCampo"
        case etiqueta = "Etiqueta"
        case obligatorio = "Obligatorio"
        case orden = "Orden"
        case longitud = "Longitud"
        case tipo = "TipoCampo"
        case valor = "Valor"
        case visible = "Visible"
        case funcion = "Funcion"
        case decimales = "Decimales"
        case formatoFecha = "FmtoFecha"
        case camara = "Camara"
        
    }
    init() {
        //constructor
    }
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        codigo = try container.decodeIfPresent(String.self, forKey: .codigo)
        etiqueta = try container.decodeIfPresent(String.self, forKey: .etiqueta)
        obligatorio = try container.decodeIfPresent(String.self, forKey: .obligatorio)
        bobligatorio = obligatorio == "S"
        
        orden = try container.decodeIfPresent(String.self, forKey: .orden) ?? "0"
        iorden = Int(orden ?? "0") ?? 0
        
        longitud = try container.decodeIfPresent(String.self, forKey: .longitud) ?? "1"
        llongitud = Int(longitud ?? "0") ?? 1
        
        let scamara = try container.decodeIfPresent(String.self, forKey: .camara)
        camara = scamara == "S"
        
        let stipo = try container.decodeIfPresent(String.self, forKey: .tipo)
        tipo = TipAtributo.init(rawValue: (stipo ?? "A")) ?? .texto
        valor = try container.decodeIfPresent(String.self, forKey: .valor)
        visible = try container.decodeIfPresent(String.self, forKey: .visible)
        bvisible = visible == "S"
        funcion = try container.decodeIfPresent(String.self, forKey: .funcion)
        if let decimal  = try container.decodeIfPresent(String.self, forKey: .decimales) {
            if !decimal.isEmpty {
                ddecimales = Int(decimal) ?? 0
            }
            decimales = decimal
        } else {
            decimales = "0"
        }
        formatoFecha = try container.decodeIfPresent(String.self, forKey: .formatoFecha)
    }
    
}

enum TipAtributo: String, Codable {
    case numero = "N"
    case texto = "A"
    case fecha = "F"
    case moneda = "M"
    case desgloce = "D"
    case barra = "B"
    case npe = "P"
    case total = "T"
    case correo = "CORREO"
    case telefono = "TELEFONO"
}
