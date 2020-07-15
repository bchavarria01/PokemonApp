//
//  WelcomeCoordinator.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/8/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit
import Presentr

final class WelcomeCoordinator: Coordinator {
    var presenter: UINavigationController
    
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    func start() {
        let controller = LoginViewController()
        controller.delegate = self
        presenter.pushViewController(controller, animated: true)
    }
    
    init(presenter: UINavigationController,
         parentCoordinator: Coordinator) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
    }
}

extension WelcomeCoordinator: LoginViewControllerDelegate {
    func loginViewControllerDidSingInSuccess() {
        let controller = RegionsViewController()
        controller.delegate = self
        let service = PokemonServices()
        controller.viewModel = RegionsViewModel(pokemonService: service)
        presenter.pushViewController(controller, animated: true)
    }
    
    func loginViewControllerDidSingUpSuccess() {
        let controller = RegionsViewController()
        controller.delegate = self
        let service = PokemonServices()
        controller.viewModel = RegionsViewModel(pokemonService: service)
        presenter.pushViewController(controller, animated: true)
    }
}

extension WelcomeCoordinator: RegionsViewControllerDelegate {
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
    func PokemonsViewControllerDidSelectPokemon(with pokemonUrl: String, and imageUrl: String) {
        let controller = PokemonDetailViewController()
        let service = PokemonServices()
        controller.pokemonImageUrl = imageUrl
        controller.pokemonDetailUrl = pokemonUrl
        controller.viewModel = PokemonDetailViewModel(pokemonService: service)
        presenter.pushViewController(controller, animated: true)
    }
}
