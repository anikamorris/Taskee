//
//  ViewTasksController.swift
//  Taskee
//
//  Created by Anika Morris on 9/24/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import CoreData

class ViewTasksController: UIViewController {
    
    //MARK: Properties
    var coordinator: AppCoordinator!
    var project: Project!
    var managedContext: NSManagedObjectContext!
    var completedTasks: [Task]!
    var incompleteTasks: [Task]!
    
    //MARK: Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    let todoDoneControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["TODO", "DONE"])
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = .green
        control.backgroundColor = .white
        control.addTarget(self, action: #selector(selectedSegmentDidChange), for: .valueChanged)
        return control
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        return tableView
    }()
    let barButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "New Task"
        label.textColor = .systemBlue
        return label
    }()
    
    //MARK: Init
    init(title: String) {
        titleLabel.text = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTintColor(element: todoDoneControl)
        loadIncompleteTasks()
        loadCompletedTasks()
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: NSNotification.Name(rawValue: "TaskAdded"), object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        createViews()
        let newTaskBarButton = UIBarButtonItem(title: "Add Task",
                                               style: .plain,
                                               target: self,
                                               action: #selector(newTask))
        self.navigationItem.rightBarButtonItem = newTaskBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshTableView()
    }
    
    //MARK: Methods
    fileprivate func createViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
        view.addSubview(todoDoneControl)
        todoDoneControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(30)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(todoDoneControl.snp_bottomMargin).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setTintColor(element: NSObject) {
        let colorName = project.color
        let color = ColorComponents(systemName: colorName)
        if type(of: element) == UISegmentedControl.self {
            todoDoneControl.selectedSegmentTintColor = color.uiColor
        } else if type(of: element) == UIButton.self {
            let button = element as! UIButton
            button.backgroundColor = color.uiColor
        }
    }
    
    @objc func selectedSegmentDidChange(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    @objc func newTask(_ sender: UIBarButtonItem) {
        coordinator.goToNewTaskController(project: project, task: nil)
    }
    
    @objc func refreshTableView() {
        loadIncompleteTasks()
        loadCompletedTasks()
        tableView.reloadData()
    }
    
    func loadIncompleteTasks() {
        let taskSearch: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "project.name == %@ AND isDone == false", project.name)
        taskSearch.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "dueDate", ascending: true)
        taskSearch.sortDescriptors = [sortDescriptor]
        do {
            let result = try managedContext.fetch(taskSearch)
            incompleteTasks = result
        } catch let error as NSError {
            print("Error: \(error) description: \(error.localizedDescription)")
        }
    }
    
    func loadCompletedTasks() {
        let taskSearch: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "project.name == %@ AND isDone == true", project.name)
        taskSearch.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "dueDate", ascending: true)
        taskSearch.sortDescriptors = [sortDescriptor]
        do {
            let result = try managedContext.fetch(taskSearch)
            completedTasks = result
        } catch let error as NSError {
            print("Error: \(error) description: \(error.localizedDescription)")
        }
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        if todoDoneControl.selectedSegmentIndex == 0 {
            setTintColor(element: sender)
            let task = incompleteTasks[sender.tag]
            task.isDone = true
            saveContext()
            todoDoneControl.selectedSegmentIndex = 1
        } else {
            let task = completedTasks[sender.tag]
            task.isDone = false
            saveContext()
            todoDoneControl.selectedSegmentIndex = 0
        }
        refreshTableView()
    }
    
    func saveContext() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), description: \(error.localizedDescription)")
            self.presentAlert(title: "There was an error saving this task. Please try again.")
        }
    }
}

extension ViewTasksController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = incompleteTasks[indexPath.row]
        coordinator.goToNewTaskController(project: project, task: task)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if todoDoneControl.selectedSegmentIndex == 0 {
                let task = incompleteTasks[indexPath.row]
                managedContext.delete(task)
            } else {
                let task = completedTasks[indexPath.row]
                managedContext.delete(task)
            }
            do {
                try managedContext.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            refreshTableView()
        }
    }
}

extension ViewTasksController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todoDoneControl.selectedSegmentIndex == 0 {
            return incompleteTasks.count
        } else {
            return completedTasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier) as! TaskCell
        if todoDoneControl.selectedSegmentIndex == 0 {
            let task = incompleteTasks[indexPath.row]
            let dueDate = task.dueDate.daysUntilDueDate()
            cell.setTitleAndDueDate(taskName: task.name, dueDate: dueDate)
            cell.labelStackView.addArrangedSubview(cell.dueDateLabel)
            cell.doneButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            let task = completedTasks[indexPath.row]
            cell.dueDateLabel.removeFromSuperview()
            cell.setTitle(taskName: task.name)
            setTintColor(element: cell.doneButton)
        }
        cell.doneButton.tag = indexPath.row
        cell.doneButton.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
}
