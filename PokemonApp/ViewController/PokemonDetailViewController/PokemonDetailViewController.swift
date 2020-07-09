//
//  PokemonDetailViewController.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/29/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit
import RxSwift

final class PokemonDetailViewController: BaseViewController {
    
    // MARK: - Components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var headerView: PokemonDetailHeaderView = {
        let view = PokemonDetailHeaderView()
        view.cornerRadius(with: [.layerMaxXMinYCorner, .layerMinXMaxYCorner], cornerRadii: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var habitatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var habitatCollectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionLayout
        )
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.cornerRadius(with: [.layerMaxXMinYCorner, .layerMinXMaxYCorner], cornerRadii: 16)
        return collectionView
    }()
    
    // MARK: - Attributes
    
    var viewModel: PokemonDetailViewModel!
    var pokemonDetailUrl: String?
    var pokemonImageUrl: String?
    let disposeBag = DisposeBag()
    
    // MARK: - DataSource
    
    private lazy var collectionDataSource: PokemonDetailViewControllerCollectionDataSource = {
        return PokemonDetailViewControllerCollectionDataSource()
    }()
    
    private lazy var collectionDelegate: PokemonDetailViewControllerCollectionDelegate = {
        return PokemonDetailViewControllerCollectionDelegate()
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bindViewModel()
        setupCollectionView()
    }
    
    // MARK: - Helpers
    
    private func bindViewModel() {
        showLoading(L10n.getPokemonDetail)
        viewModel.getPokemonDetail(with: pokemonDetailUrl ?? "")
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.dismiss(animated: true, completion: {
                            self.setupInforamation(with: data)
                        })
                    })
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.dismiss(animated: true, completion: {
                            self.showActionMessage(title: L10n.error, message: error.localizedDescription)
                            print(error.localizedDescription)
                        })
                    })
            }).disposed(by: disposeBag)
    }
    
    private func setupInforamation(with data: PokemonDetailResponseModel) {
        let pokemonBaseDetailModel = PokemonBaseDetailModel(
            pokemonImageUrl: self.pokemonImageUrl ?? "",
            pokemonName: data.name ?? "",
            baseHappiness: String(data.baseHappiness ?? 0),
            captureRate: String(data.captureRate ?? 0),
            generation: String(data.generation?.name ?? "")
        )
        self.headerView.backgroundColor = data.color?.name?.getColorByPokemonColor()
        self.habitatCollectionView.backgroundColor = data.color?.name?.getColorByPokemonColor()
        self.view.backgroundColor = UIColor(named: (data.color?.name?.capitalizingFirstLetter())!)
        self.headerView.setupHeaderContent(with: pokemonBaseDetailModel)
        self.habitatLabel.text = "Pokemons from habitat: \(data.habitat?.name ?? "")"
        self.bindCollectionInformation(using: data.habitat?.url ?? "")
    }
    
    private func bindCollectionInformation(using habitatUrl: String) {
        showLoading(L10n.getHabitatInformation)
        viewModel.getHabitatInformation(with: habitatUrl)
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.dismiss(animated: true, completion: {
                            self.collectionDelegate.items = data.pokemonSpecies!
                            self.collectionDataSource.items = data.pokemonSpecies!
                            self.habitatCollectionView.reloadData()
                        })
                    })
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.dismiss(animated: true, completion: {
                            self.showActionMessage(title: L10n.error, message: error.localizedDescription)
                            print(error.localizedDescription)
                        })
                    })
            }).disposed(by: disposeBag)
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headerView)
        contentView.addSubview(habitatLabel)
        contentView.addSubview(habitatCollectionView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            
            headerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            headerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            headerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.70),
            headerView.widthAnchor.constraint(equalToConstant: 350),
            
            habitatLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            habitatLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            habitatCollectionView.topAnchor.constraint(equalTo: habitatLabel.bottomAnchor, constant: 8),
            habitatCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            habitatCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            habitatCollectionView.heightAnchor.constraint(equalToConstant: 120),
        ])
        
        let contentViewHeigthConstraint = contentView.heightAnchor.constraint(
            equalTo: view.heightAnchor
        )
        contentViewHeigthConstraint.priority = .defaultLow
        contentViewHeigthConstraint.isActive = true
    }
    
    private func setupCollectionView() {
        habitatCollectionView.register(cellType: PokemonsCollectionViewCell.self)
        habitatCollectionView.dataSource = collectionDataSource
        habitatCollectionView.delegate = collectionDelegate
    }
    
}
