//
//  LoginViewControllerDelegate.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/12/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation

protocol LoginViewControllerDelegate: class {
    func loginViewControllerDidSingInSuccess()
    func loginViewControllerDidSingUpSuccess()
}
