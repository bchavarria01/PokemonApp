//
//  PokemonCellView.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/5/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class PokemonCellView: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    var pokemon : PokemonModel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 7.0
    }
}
