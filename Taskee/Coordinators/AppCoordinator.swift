//
//  AppCoordinator.swift
//  Taskee
//
//  Created by Anika Morris on 9/24/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AppCoordinator: Coordinator {
    
    //MARK: Properties
    var childCoordinators: [Coordinator] = []
    lazy var navigationController: UINavigationController = UINavigationController()
    var managedContext: NSManagedObjectContext!
    
    //MARK: Init
    init(window: UIWindow) {
        window.rootViewController = navigationController
        setupNavigationController()
    }
    
    //MARK: Methods
    func start() {
        let vc = HomeController()
        vc.coordinator = self
        vc.managedContext = self.managedContext
        navigationController.pushViewController(vc, animated: false)
    }
}

//MARK: Private Methods
private extension AppCoordinator {
    func setupNavigationController() {
        self.navigationController.isNavigationBarHidden = false
        self.navigationController.navigationBar.backgroundColor = .white
//        self.navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController.navigationBar.shadowImage = UIImage()
    }
}

//MARK: New Project
extension AppCoordinator {
    func goToNewProjectController() {
        let vc = NewProjectController()
        vc.coordinator = self
        vc.managedContext = self.managedContext
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func goBackToHomeController() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

//MARK: Task Flow
extension AppCoordinator {
    func goToViewTasksController(project: Project) {
        let vc = ViewTasksController.init(title: project.name)
        vc.coordinator = self
        vc.project = project
        navigationController.pushViewController(vc, animated: true)
    }
    
    func testingViewTasksController() {
        let vc = ViewTasksController.init(title: "Project Name")
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToNewTaskController() {
        let vc = NewTaskController()
        vc.coordinator = self
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func goBackToViewTasksController() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
