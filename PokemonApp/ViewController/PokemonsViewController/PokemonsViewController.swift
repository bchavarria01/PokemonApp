//
//  PokemonsViewController.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/10/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit
import Reusable
import RxSwift

final class PokemonsViewController: BaseViewController, StoryboardBased {
    
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

    
    // MARK: - Attributes
    
    var previousOffsetState: CGFloat = 0
    var coverHeightConstraint: NSLayoutConstraint?
    weak var delegate: PokemonsViewControllerDelegate?
    var viewModel: PokemonsViewModel!
    var regionUrl: String?
    var disposeBag = DisposeBag()
    var regionName: String?
    var items: [PokemonEntry] = []
    
    // MARK: - IBOutLetss
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeigthAnchor: NSLayoutConstraint!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bindViewModel()
        setupCollectionView()
        titleLabel.text = self.regionName!
        
        var image: UIImage {
            switch regionName {
                case "kanto": return R.Base.kanto.image
                case "johto": return R.Base.johto.image
                case "hoenn": return R.Base.hoenn.image
                case "unova": return R.Base.unova.image
                case "kalos": return R.Base.kalos.image
                case "alola": return R.Base.alola.image
                case "sinnoh": return R.Base.sinnoh.image
                default: return R.Base.galar.image
            }
        }
        imageView.image = image
    }
    
    // MARK: - Helpers
    
    private func bindViewModel() {
        showLoading("\(L10n.getPokemonsMessage) \(regionName!)")
        viewModel.getPokemonsPerRegion(regionsUrl: regionUrl ?? "")
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self.viewModel.getPokedexInfop(pokedexUrl: data.pokedexes?[0].url ?? "")
                    .subscribe(
                        onSuccess: { [weak self] res in
                            guard let self = self else { return }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.dismiss(animated: true, completion: {
                                    self.items = res.pokemonEntries ?? []
                                    self.collectionDataSource.items = res.pokemonEntries ?? []
                                    self.collectionView.reloadData()
                                })
                            })
                        }, onError: { [weak self] error in
                            guard let self = self else { return }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.dismiss(animated: true, completion: {
                                    self.showActionMessage(title: L10n.error, message: error.localizedDescription)
                                })
                            })
                    }).disposed(by: self.disposeBag)
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.dismiss(animated: true, completion: {
                            self.showActionMessage(title: L10n.error, message: error.localizedDescription)
                        })
                    })
            }).disposed(by: disposeBag)
    }
    
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
        let url = items[indexPath.row].pokemonSpecies?.url ?? ""
        delegate?.PokemonsViewControllerDidSelectPokemon(with: url, and: url.getImageUrl())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
