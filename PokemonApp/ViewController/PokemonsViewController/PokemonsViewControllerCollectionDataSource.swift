//
//  PokemonsViewControllerCollectionDataSource.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/18/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

final class PokemonsViewControllerCollectionDataSource: NSObject {
    var items: [PokemonEntry] = []
}

extension PokemonsViewControllerCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PokemonsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let urlReplaced = items[indexPath.row].pokemonSpecies?.url?.getImageUrl()
        let url = URL(string: urlReplaced!)
        cell.pokemonName.text = items[indexPath.row].pokemonSpecies?.name?.capitalizingFirstLetter() ?? ""
        cell.pokemonImage.load(url: url!)
        return cell
    }
}
