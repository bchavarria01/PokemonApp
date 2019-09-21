//
//  TeamDataCellView.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/5/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class TeamDataCellView: BaseCeldaCellView {
    @IBOutlet weak var textField: UITextField?
    static var identifier: String {
        return "teamDataCell"
    }
}
