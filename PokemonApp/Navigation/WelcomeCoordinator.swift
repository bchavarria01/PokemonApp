//
//  WelcomeCoordinator.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/8/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

final class WelcomeCoordinator: Coordinator {
    var presenter: UINavigationController
    
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    func start() {
        let controller = RegionsViewController()
        controller.delegate = self
        let service = PokemonServices()
        controller.viewModel = RegionsViewModel(pokemonService: service)
        presenter.pushViewController(controller, animated: true)
    }
    
    init(presenter: UINavigationController,
         parentCoordinator: Coordinator) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
    }
}

extension WelcomeCoordinator: RegionsViewDelegate {
    func regionsViewControllerDidSelectRegion(with regionUrl: String, and name: String) {
        let controller = PokemonsViewController.instantiate()
        let service = PokemonServices()
        controller.viewModel = PokemonsViewModel(pokemonService: service)
        controller.delegate = self
        controller.regionUrl = regionUrl
        controller.regionName = name
        presenter.pushViewController(controller, animated: true)
    }
}

extension WelcomeCoordinator: PokemonsViewControllerDelegate {
    func PokemonsViewControllerDidSelectPokemon(with pokemonUrl: String) {
        
    }
}
