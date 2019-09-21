//
//  CeldaPersonalizada.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/5/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class CeldaPersonalizada: DetalleCell {
    var nombre: String?
    var alto: CGFloat = 0.0
    var celda: BaseCeldaCellView.Type?
    var nibName: String?
    var id: String?
    var seccion = 0
    init(nombre: String?, alto: CGFloat, celda: BaseCeldaCellView.Type?, nibName: String?="", id: String? = "", seccion: Int = 0) {
        self.nombre = nombre
        self.alto = alto
        self.celda = celda
        self.nibName = nibName
        self.id = id
        self.seccion = seccion
    }
    
}
