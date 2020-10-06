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
    var task: Task?
    var project: Project!
    var managedContext: NSManagedObjectContext!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let task = task {
            self.view = NewTaskView.init(frame: .zero, title: "Edit Task", parentVC: self)
            let newTaskView = view as! NewTaskView
            populateTaskView(view: newTaskView, taskName: task.name, date: task.dueDate)
        } else {
            self.view = NewTaskView.init(frame: .zero, title: "New Task", parentVC: self)
        }
        let newTaskView = view as! NewTaskView
        let colorComponent = ColorComponents.init(systemName: project.color)
        let color = colorComponent.uiColor
        newTaskView.dueDateTextField.textColor = color
        newTaskView.taskNameTextField.textColor = color
        newTaskView.saveTaskDelegate = self
    }
    
    //MARK: Methods
    func populateTaskView(view: NewTaskView, taskName: String, date: Date) {
        view.taskNameTextField.text = taskName
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let dueDate = formatter.string(from: date)
        view.dueDateTextField.text = dueDate
    }
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
        if let task = task {
            task.dueDate = date
            task.name = title
        } else {
            let task = Task(context: managedContext)
            task.name = title
            task.dueDate = date
            task.project = project
            task.isDone = false
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), description: \(error.localizedDescription)")
            self.presentAlert(title: "There was an error saving this task. Please try again.")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TaskAdded"), object: nil)
        coordinator.goBackToViewTasksController()
    }
}
