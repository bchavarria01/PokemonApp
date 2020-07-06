//
//  PokemonsViewControllerDelegate.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/5/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation

protocol PokemonsViewControllerDelegate: class {
    func PokemonsViewControllerDidSelectPokemon(with pokemonUrl: String)
}
