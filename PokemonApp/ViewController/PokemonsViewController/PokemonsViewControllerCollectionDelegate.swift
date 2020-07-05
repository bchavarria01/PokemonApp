//
//  PokemonsViewControllerCollectionDelegate.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/18/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

final class PokemonsViewControllerCollectionDelegate: NSObject {
    
}

extension PokemonsViewControllerCollectionDelegate: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        //let width = collectionView.frame.width - 32
        return CGSize(width: 104, height: 104)
    }
}
