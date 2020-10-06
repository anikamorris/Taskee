//
//  NewTaskController.swift
//  Taskee
//
//  Created by Anika Morris on 9/25/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import CoreData

class NewTaskController: UIViewController {
    
    //MARK: Properties
    var coordinator: AppCoordinator!
    var task: String?
    var project: Project!
    var managedContext: NSManagedObjectContext!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = task {
            self.view = NewTaskView.init(frame: .zero, title: "Edit Task", parentVC: self)
        } else {
            self.view = NewTaskView.init(frame: .zero, title: "New Task", parentVC: self)
        }
        let newTaskView = view as! NewTaskView
        newTaskView.saveTaskDelegate = self
    }
    
    //MARK: Methods
}

extension NewTaskController: SaveTaskDelegate {
    func saveTask(title: String, dueDate: String) {
        if title == "" {
            self.presentAlert(title: "Task must have a name.")
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        guard let date = formatter.date(from: dueDate) else {
            self.presentAlert(title: "Task due date must be in format mm/dd/yyyy.")
            return
        }
        let task = Task(context: managedContext)
        task.name = title
        task.dueDate = date
        task.project = project
        do {
            try managedContext.save()
            print("should've saved \(task.name) for project \(task.project)")
        } catch let error as NSError {
            print("Error: \(error), description: \(error.localizedDescription)")
            self.presentAlert(title: "There was an error saving this task. Please try again.")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TaskAdded"), object: nil)
        coordinator.goBackToViewTasksController()
    }
}
