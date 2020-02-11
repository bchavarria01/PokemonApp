//
//  RegionsViewControllerTableDataSource.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/10/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

final class RegionsViewControllerTableDataSource: NSObject {
    
}

extension RegionsViewControllerTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RegionsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
