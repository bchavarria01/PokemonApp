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
            font: .systemFont(ofSize: 14),
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
        return tableDataSource
    }()
    
    // MARK: - LifeCyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupTableView()
    }
    
    // MARK: - Helpers
    
    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalToConstant: 96),
        
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
        
        tableView.register(cellType: RegionsTableViewCell.self)
    }
    
}
