//
//  PokemonsViewController.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/10/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit
import Reusable

final class PokemonsViewController: UIViewController, StoryboardBased {
    
    // MARK: - Components
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = R.Base.galar.image
        return imageView
    }()
    
    lazy var barView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.cornerRadius(with: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner], cornerRadii: 32)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Galar"
        label.textColor = .black
        return label
    }()
    
    lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.Base.pokeball2.image
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionLayout
        )
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: DataSources
    
    private lazy var collectionDataSource: PokemonsViewControllerCollectionDataSource = {
        return PokemonsViewControllerCollectionDataSource()
    }()
    
    // MARK: Delegates
    
    private lazy var collectionDelegate: PokemonsViewControllerCollectionDelegate = {
        return PokemonsViewControllerCollectionDelegate()
    }()
    
    // MARK: - Attributes
    
    var previousOffsetState: CGFloat = 0
    var coverHeightConstraint: NSLayoutConstraint?
    
    // MARK: - IBOutLetss
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeigthAnchor: NSLayoutConstraint!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupCollectionView()
    }
    
    // MARK: - Helpers
    
    private func setupLayout() {
        
        topView.clipsToBounds = true
        topView.addSubview(imageView)
        barView.addSubview(titleLabel)
        barView.addSubview(backImage)
        
        view.addSubview(contentView)
        contentView.addSubview(topView)
        contentView.addSubview(barView)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: topView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),

            barView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            barView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            barView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            barView.heightAnchor.constraint(equalToConstant: 56),
            
            backImage.heightAnchor.constraint(equalToConstant: 32),
            backImage.widthAnchor.constraint(equalToConstant: 32),
            
            backImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backImage.centerYAnchor.constraint(equalTo: barView.centerYAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: barView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: barView.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: barView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            
        ])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = collectionDataSource
        
        collectionView.register(cellType: PokemonsCollectionViewCell.self)
    }
    
}

// MARK: - UIScrollViewDelegate

extension PokemonsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 104, height: 104)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Collapse View
        let offsetDiff =  previousOffsetState - scrollView.contentOffset.y
        previousOffsetState = scrollView.contentOffset.y
        let newHeight = topViewHeigthAnchor.constant + offsetDiff
        
        if newHeight > 0 {
            topViewHeigthAnchor.constant = newHeight
        }
        
        if scrollView.contentOffset.y > 256 {
            topViewHeigthAnchor.constant = 0
        }
        
        // Rotate image
        let topOffset = scrollView.contentOffset.y
        let angle = -topOffset * 2 * CGFloat(Double.pi / 180)
        self.backImage.transform = CGAffineTransform(rotationAngle: angle)
    }
}
