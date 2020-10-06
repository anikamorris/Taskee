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
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = NewProjectView.init(frame: view.frame,
                                        colors: colors)
        let newProjectView = self.view as! NewProjectView
        newProjectView.saveProjectDelegate = self
    }
    
    //MARK: Methods
    func colorNameFromUIColor(greenComponent: CGFloat) -> String {
        for color in ColorComponents.allCases {
            switch color {
            default:
                if color.greenComponent == greenComponent {
                    return color.systemName
                }
            }
        }
        return ""
    }
}

extension NewProjectController: SaveProjectDelegate {
    func saveProject(title: String, color: UIColor) {
        let greenComponent = color.cgColor.components![1]
        let colorName = colorNameFromUIColor(greenComponent: greenComponent)
        print(colorName)
        let project = Project(context: managedContext)
        project.name = title
        project.color = colorName
        do {
            try managedContext.save()
            print("should've saved \(project.name) with color \(project.color)")
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProjectAdded"), object: nil)
        coordinator.goBackToHomeController()
    }
}
