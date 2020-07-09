//
//  RegionsViewControllerTableDataSource.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/10/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

final class RegionsViewControllerTableDataSource: NSObject {
    // MARK: - Attributes
    var items: [PokemonResponse] = []
}

extension RegionsViewControllerTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RegionsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.regionName?.text = items[indexPath.row].name?.capitalizingFirstLetter() ?? ""
        cell.selectionStyle = .none
        return cell
    }
}
