//
//  PokemonsHelper.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/6/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Foundation
import FittedSheets
protocol PokemonsHelper {
    //protocolo para el parentesco
}
extension PokemonsHelper {
    /// funcion para el diseno del modal de parentesco
    ///
    /// - Parameters:
    ///   - titulo: titulo String
    func mostrarInfoPokemonModal(titulo: String, rootController: UIViewController) {
        if self is CampoSimpleCellView {
            let controller = CreateTeamViewController.instantiate()
            if self is SelectPokemonDelegate {
                controller.delegate = rootController as? SelectPokemonDelegate
            }
            let  sizes: [SheetSize] = [.fixed(450.0), .fixed(550.0), .halfScreen]
            let sheetController = SheetViewController(controller: controller, sizes: sizes )
            //configuracion del modal de las cuentas
            sheetController.title = titulo
            sheetController.adjustForBottomSafeArea = true
            sheetController.blurBottomSafeArea = false
            sheetController.topCornersRadius = 40
            sheetController.dismissOnBackgroundTap = true
            sheetController.extendBackgroundBehindHandle = false
            sheetController.pullBarView.frame = CGRect(x: 0, y: 0, width: 20, height: 40)
            sheetController.pullBarView.isHidden = true
            //controller.tituloEncabezado = titulo
            rootController.present(sheetController, animated: false)
        }
    }
}

