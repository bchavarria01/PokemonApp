//
//  RegionsViewDelegate.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/4/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import Foundation

protocol RegionsViewDelegate: class {
    func regionsViewControllerDidSelectRegion(with regionUrl: String, and name: String)
}
