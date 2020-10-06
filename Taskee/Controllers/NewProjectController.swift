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
    }
}

enum ColorComponents: CaseIterable {
    case red, pink, orange, teal, green, yellow, purple, blue, indigo
    
    var systemName: String {
        switch self {
        case .red:
            return "systemRed"
        case .pink:
            return "systemPink"
        case .orange:
            return "systemOrange"
        case .teal:
            return "systemTeal"
        case .green:
            return "systemGreen"
        case .yellow:
            return "systemYellow"
        case .purple:
            return "systemPurple"
        case .blue:
            return "systemBlue"
        case .indigo:
            return "systemIndigo"
        }
    }
        
    var greenComponent: CGFloat {
        switch self {
        case .red:
            return 0.23137254901960785
        case .pink:
            return 0.17647058823529413
        case .orange:
            return 0.5843137254901961
        case .teal:
            return 0.7843137254901961
        case .green:
            return 0.7803921568627451
        case .yellow:
            return 0.8
        case .purple:
            return 0.3215686274509804
        case .blue:
            return 0.47843137254901963
        case .indigo:
            return 0.33725490196078434
        }
    }
}
