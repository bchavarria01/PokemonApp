//
//  ApplicationCoordinator.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/8/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
            
    // MARK: - Attributes
    
    let window: UIWindow
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    // MARK: - LifeCycle
    
    init(window: UIWindow) {
        self.window = window
        presenter = UINavigationController()
        presenter.navigationBar.isHidden = true
        window.rootViewController = presenter
    }
    
    // MARK: Start
    
    func start() {
        let authenticationCoordinator = WelcomeCoordinator(
            presenter: presenter,
            parentCoordinator: self
        )
        authenticationCoordinator.start()
        window.makeKeyAndVisible()
        addChildCoordinator(authenticationCoordinator)
    }
    
}

