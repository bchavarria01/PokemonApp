//
//  PokemonDetailViewControllerCollectionDelegate.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/8/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

final class PokemonDetailViewControllerCollectionDelegate: NSObject {
    var items: [PokemonResponse] = []
    weak var delegate: PokemonDetailViewControllerDelegate?
}

extension PokemonDetailViewControllerCollectionDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = items[indexPath.row].url ?? ""
        _ = url
        delegate?.PokemonDetailViewControllerDidSelectPokemon()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104, height: 104)
    }
}
