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
        let urlReplaced = items[indexPath.row].pokemonSpecies?.url?.replacingOccurrences(of: "pokemon-species", with: "pokemon")
        let newUrl = urlReplaced?.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon",
                                                      with: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon")
        let urlImage = "\(newUrl!.dropLast()).png"
        let url = URL(string: urlImage)
        cell.pokemonName.text = items[indexPath.row].pokemonSpecies?.name ?? ""
        cell.pokemonImage.load(url: url!)
        return cell
    }
}
