//
//  RegionsViewControllerDelegate.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/18/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation

protocol RegionsViewControllerDelegate: class {
    func regionsViewControllerDidSelectRegion(with url: String, and name: String)
}
