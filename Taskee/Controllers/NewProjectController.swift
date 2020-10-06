//
//  NewProjectController.swift
//  Taskee
//
//  Created by Anika Morris on 9/24/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewProjectController: UIViewController {
    
    //MARK: Properties
    var coordinator: AppCoordinator!
    var managedContext: NSManagedObjectContext!
    let colors: [UIColor] = [.systemRed, .systemPink, .systemOrange, .systemTeal, .systemGreen, .systemYellow, .systemPurple, .systemBlue, .systemIndigo]
    var titleTextField: UITextField!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = NewProjectView.init(frame: view.frame,
                                        colors: colors)
        let newProjectView = self.view as! NewProjectView
        newProjectView.saveProjectDelegate = self
        self.titleTextField = newProjectView.titleTextField
        titleTextField.delegate = self
    }
    
    //MARK: Methods
    
}

extension NewProjectController: SaveProjectDelegate {
    func saveProject(title: String, color: UIColor?) {
        if title == "" {
            self.presentAlert(title: "Project must have a name.")
            return
        }
        guard let color = color else {
            self.presentAlert(title: "Project must have a color.")
            return
        }
        let greenComponent = color.cgColor.components![1]
        let colorComponent = ColorComponents.init(greenComponent: greenComponent)
        let colorName = colorComponent.systemName
        let project = Project(context: managedContext)
        project.name = title
        project.color = colorName
        do {
            try managedContext.save()
            print("saved \(project.name) with color \(project.color)")
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProjectAdded"), object: nil)
        coordinator.goBackToHomeController()
    }
}

extension NewProjectController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
