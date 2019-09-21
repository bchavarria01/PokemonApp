//
//  RegionPresenter.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/4/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class RegionPresenter {
    var view: RegionView?
    func attachView(view: RegionView) {
        self.view = view
    }
    /// descarga de idEnlace
    func getRegions() {
        self.view?.showWait("Getting regions info.")
        Services.shared.getRegions(success: {(region) in
            self.view?.dismissMsg()
            self.view?.getRegions(region)
        }, fail: { (msgError) in
            self.view?.showError(msgError)
            self.view?.dismissMsg()
        })
    }
}
/// protocolo de menu para obtener enlace
protocol RegionView: BaseView {
    /// Función encargada de obtenerEnlaceP2P
    ///
    /// - Parameter enlace: Objeto de tipo EnlaceP2P
    func getRegions(_ region: [Result1]?)
}
