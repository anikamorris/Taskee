//
//  NewProjectController.swift
//  Taskee
//
//  Created by Anika Morris on 9/24/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

class NewProjectController: UIViewController {
    
    //MARK: Properties
    var coordinator: AppCoordinator!
    let colors: [UIColor] = [.systemRed, .systemPink, .systemOrange, .systemTeal, .systemGreen, .systemYellow, .systemPurple, .systemBlue, .systemIndigo]
    var color: UIColor?
    var projectName: String?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = NewProjectView.init(frame: view.frame,
                                        colors: colors,
                                        parentVC: self)
        let newProjectView = self.view as! NewProjectView
        let saveButton = newProjectView.saveButton
        saveButton.addTarget(self, action: #selector(saveProject), for: .touchUpInside)
    }
    
    //MARK: Methods
    @objc func saveProject(_ sender: UIButton) {
        coordinator.goBackToHomeController()
    }
}
