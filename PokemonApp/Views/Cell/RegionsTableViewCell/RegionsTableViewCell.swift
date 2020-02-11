//
//  RegionsTableViewCell.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/10/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit
import Reusable

class RegionsTableViewCell: UITableViewCell, NibReusable {

    // MARK: - IBOutlets
    
    @IBOutlet weak var regionName: UILabel!
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
