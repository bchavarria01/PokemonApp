//
//  PokemonsCollectionViewCell.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/18/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit
import Reusable

class PokemonsCollectionViewCell: UICollectionViewCell, NibReusable {

    // MARK: - IBOutlets
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
