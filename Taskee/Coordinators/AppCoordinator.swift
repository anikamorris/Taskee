//
//  AppCoordinator.swift
//  Taskee
//
//  Created by Anika Morris on 9/24/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    //MARK: Properties
    var childCoordinators: [Coordinator] = []
    lazy var navigationController: UINavigationController = UINavigationController()
    
    //MARK: Init
    init(window: UIWindow) {
        window.rootViewController = navigationController
//        setupNavigationController()
    }
    
    //MARK: Methods
    func start() {
        let vc = HomeController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}

//MARK: Private Methods
private extension AppCoordinator {
    func setupNavigationController() {
        self.navigationController.isNavigationBarHidden = false
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.backgroundColor = .systemBackground
        self.navigationController.navigationBar.tintColor = .systemBlue 
    }
}

//MARK: New Project
extension AppCoordinator {
    func goToNewProjectController() {
        let vc = NewProjectController()
        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func goBackToHomeController() {
//        navigationController.popViewController(animated: true)
        navigationController.dismiss(animated: true, completion: nil)
    }
}
