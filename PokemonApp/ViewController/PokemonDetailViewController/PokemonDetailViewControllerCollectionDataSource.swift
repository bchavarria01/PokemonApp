//
//  PokemonDetailViewControllerCollectionDataSource.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/8/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

final class PokemonDetailViewControllerCollectionDataSource: NSObject {
    var items: [PokemonResponse] = []
}

extension PokemonDetailViewControllerCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PokemonsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let urlReplaced = items[indexPath.row].url?.getImageUrl()
        let url = URL(string: urlReplaced!)
        cell.pokemonName.text = items[indexPath.row].name?.capitalizingFirstLetter() ?? ""
        cell.pokemonName.textColor = .black
        cell.pokemonImage.load(url: url!)
        return cell
    }
}
