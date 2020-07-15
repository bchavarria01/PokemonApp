//
//  PokemonDetailHeaderView.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/7/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

final class PokemonDetailHeaderView: UIView {
    
    // MARK: - Components
    
    lazy var pokemonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.Base.pokeball2.image
        image.contentMode = .scaleAspectFit
        image.rotateImageInfinite()
        return image
    }()
    
    lazy var labelsStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 4
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var baseHappiness: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var captureRate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var generation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var eggGroups: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var growthRate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var habitat: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var shape: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Helpers
    
    private func setupLayout() {
        
        labelsStackView.addArrangedSubview(pokemonName)
        labelsStackView.addArrangedSubview(baseHappiness)
        labelsStackView.addArrangedSubview(captureRate)
        labelsStackView.addArrangedSubview(generation)
        labelsStackView.addArrangedSubview(eggGroups)
        labelsStackView.addArrangedSubview(growthRate)
        labelsStackView.addArrangedSubview(habitat)
        labelsStackView.addArrangedSubview(shape)

        addSubview(pokemonImage)
        addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            
            pokemonImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            pokemonImage.heightAnchor.constraint(equalToConstant: 96),
            pokemonImage.widthAnchor.constraint(equalToConstant: 96),
            
            pokemonImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
            
        ])
    }
    
    func setupHeaderContent(with pokemonBaseDataModel: PokemonBaseDetailModel) {
        let mainPokemonNameString = "\(L10n.pokemonName)\(pokemonBaseDataModel.pokemonName)"
        let mainPokemonHappiness = "\(L10n.pokemonBaseHappiness)\(pokemonBaseDataModel.baseHappiness)"
        let mainPokemonCaptureRate = "\(L10n.pokemonCaptureRate)\(pokemonBaseDataModel.captureRate)"
        let mainPokemonGeneration = "\(L10n.pokemonGeneration)\(pokemonBaseDataModel.generation)"
        let mainPokemonEggGroups = "\(L10n.pokemonEggGroups)\(pokemonBaseDataModel.eggGroups)"
        let mainPokemonGrowthRate = "\(L10n.pokemonGrowthRate)\(pokemonBaseDataModel.growthRate)"
        let mainPokemonHabitat = "\(L10n.pokemonHabitat)\(pokemonBaseDataModel.habitat)"
        let mainPokemonShape = "\(L10n.pokemonShape)\(pokemonBaseDataModel.shape)"
        let url = URL(string: pokemonBaseDataModel.pokemonImageUrl)!
        pokemonImage.load(url: url)
        pokemonImage.stopRotation()
        pokemonName.attributedText = setupAttributedLabels(with: mainPokemonNameString, and: pokemonBaseDataModel.pokemonName)
        baseHappiness.attributedText = setupAttributedLabels(with: mainPokemonHappiness, and: pokemonBaseDataModel.baseHappiness)
        captureRate.attributedText = setupAttributedLabels(with: mainPokemonCaptureRate, and: pokemonBaseDataModel.captureRate)
        generation.attributedText = setupAttributedLabels(with: mainPokemonGeneration, and: pokemonBaseDataModel.generation)
        eggGroups.attributedText = setupAttributedLabels(with: mainPokemonEggGroups, and: pokemonBaseDataModel.eggGroups)
        growthRate.attributedText = setupAttributedLabels(with: mainPokemonGrowthRate, and: pokemonBaseDataModel.growthRate)
        habitat.attributedText = setupAttributedLabels(with: mainPokemonHabitat, and: pokemonBaseDataModel.habitat)
        shape.attributedText = setupAttributedLabels(with: mainPokemonShape, and: pokemonBaseDataModel.shape)
    }
    
    private func setupAttributedLabels(with mainString: String, and stringForRange: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString.attributedString(
            mainString,
            font: .boldSystemFont(ofSize: 12),
            color: .black
        )
        
        let rangeName = (mainString as NSString).range(of: stringForRange)
        attributedText.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.preferredFont(forTextStyle: .caption1),
            range: rangeName
        )
        return attributedText
    }
}
