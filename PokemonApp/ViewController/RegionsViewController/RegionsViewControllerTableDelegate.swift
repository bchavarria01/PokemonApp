//
//  RegionsViewControllerTableDelegate.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/10/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

final class RegionsViewControllerTableDelegate: NSObject {
    
    weak var delegate: RegionsViewControllerDelegate?
    var items: [PokemonResponse] = []
    
}

extension RegionsViewControllerTableDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.regionsViewControllerDidSelectRegion(with: items[indexPath.row].url ?? "", and: items[indexPath.row].name ?? "")
    }
}
