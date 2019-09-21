//
//  CreateTeamPresenter.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/5/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Foundation

class CreateTeamPresenter {
    var view: CreateTeamView?
    func attachView(view: CreateTeamView) {
        self.view = view
    }
    /// descarga de idEnlace
    func getPokemonByRegion(url: String) {
        self.view?.showWait("Getting region info.")
        Services.shared.getPokemonsPerRegion(url: url, success: {(region) in
            self.view?.dismissMsg()
            self.view?.getPokemonByRegion(region)
        }, fail: { (msgError) in
            self.view?.showError(msgError)
            self.view?.dismissMsg()
        })
    }
}
/// protocolo de menu para obtener enlace
protocol CreateTeamView: BaseView {
    /// Función encargada de obtenerEnlaceP2P
    ///
    /// - Parameter enlace: Objeto de tipo EnlaceP2P
    func getPokemonByRegion(_ pokemonsRegion: Dictionary<String, String>)
}
