//
//  DetailPokemonCellView.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/10/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Foundation
import UIKit

class DetailPokemonCellView: BaseCeldaCellView {
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBaseExperience: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWidht: UILabel!
    @IBOutlet weak var btnAddPokemon: UIButton!
}
