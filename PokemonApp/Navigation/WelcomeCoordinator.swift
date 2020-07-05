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
        presenter.pushViewController(controller, animated: true)
    }
    
    init(presenter: UINavigationController,
         parentCoordinator: Coordinator) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
    }
}

extension WelcomeCoordinator: RegionsViewDelegate {
    func regionsViewControllerDidSelectRegion() {
        let controller = PokemonsViewController.instantiate()
        presenter.pushViewController(controller, animated: true)
    }
}
