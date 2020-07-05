//
//  HomeViewController.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/8/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

final class RegionsViewController: UIViewController {
    
    // MARK: - Components
    
    lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.cornerRadius(with: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner], cornerRadii: 32)
        return view
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.Icons.pokemonIcon.image
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributtedText = NSMutableAttributedString.attributedString(
            "Regions",
            font: .boldSystemFont(ofSize: 16),
            color: .gray
        )
        label.attributedText = attributtedText
        label.textAlignment = .center
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Table DataSources
    
    private lazy var tableDataSource: RegionsViewControllerTableDataSource = {
        let tableDataSource = RegionsViewControllerTableDataSource()
        return tableDataSource
    }()
    
    // MARK: - Table Delegate
    
    private lazy var tableDelegate: RegionsViewControllerTableDelegate = {
        let tableDataSource = RegionsViewControllerTableDelegate()
        tableDataSource.delegate = self
        return tableDataSource
    }()
    
    // MARK: - Attributes
    
    weak var delegate: RegionsViewDelegate?
    
    // MARK: - LifeCyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupTableView()
    }
    
    // MARK: - Helpers
    
    private func setupLayout() {
        topView.addSubview(imageView)
        topView.addSubview(titleLabel)
        
        view.addSubview(backView)
        view.addSubview(topView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 96),
            
            topView.topAnchor.constraint(equalTo: backView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 180),
        
            imageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 40),
            imageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -40),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -16),
            tableView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
        
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
        
        tableView.register(cellType: RegionsTableViewCell.self)
    }
}

extension RegionsViewController: RegionsViewControllerDelegate {
    func regionsViewControllerDidSelectRegion() {
        delegate?.regionsViewControllerDidSelectRegion()
    }
}
