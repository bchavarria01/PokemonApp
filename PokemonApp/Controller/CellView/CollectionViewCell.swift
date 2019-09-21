//
//  CollectionViewCell.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/5/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class CollectionViewCell: BaseCeldaCellView {
    @IBOutlet weak var collectionView: UICollectionView?
    static var identifier: String {
        return "collectionViewCell"
    }
}

extension CollectionViewCell {
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDelegate & UICollectionViewDataSource>(_ dataSourceDelegate: D, forRow row: Int) {
        collectionView?.delegate = dataSourceDelegate
        collectionView?.dataSource = dataSourceDelegate
        
        collectionView?.reloadData()
    }
}
