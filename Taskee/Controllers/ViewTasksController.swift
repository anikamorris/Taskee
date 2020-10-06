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
    var tasks: [Task]!
    
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
        setSelectedIndexTintColor()
        loadTasksForProject()
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
    
    func setSelectedIndexTintColor() {
        let colorName = project.color
        let color = ColorComponents(systemName: colorName)
        todoDoneControl.selectedSegmentTintColor = color.uiColor
    }
    
    @objc func selectedSegmentDidChange(_ sender: UISegmentedControl) {
        let cells = tableView.visibleCells as! [TaskCell]
        if todoDoneControl.selectedSegmentIndex == 0 {
            if cells.count > 0 {
                for i in 0...cells.count-1 {
                    let cell = cells[i]
                    cell.doneButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    let labelStackView = cell.labelStackView
                    if labelStackView.subviews.count == 1 {
                        cell.setDueDate(dueDate: "3 days left")
                        labelStackView.addArrangedSubview(cell.dueDateLabel)
                    }
                }
            }
        } else {
            for cell in cells {
                cell.doneButton.backgroundColor = #colorLiteral(red: 0.2588235294, green: 1, blue: 0.262745098, alpha: 1)
                cell.dueDateLabel.removeFromSuperview()
            }
        }
    }
    
    @objc func newTask(_ sender: UIBarButtonItem) {
        coordinator.goToNewTaskController(project: project)
    }
    
    @objc func refreshTableView() {
        loadTasksForProject()
        tableView.reloadData()
    }
    
    func loadTasksForProject() {
        let taskSearch: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "project.name == %@", project.name)
        taskSearch.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "dueDate", ascending: true)
        taskSearch.sortDescriptors = [sortDescriptor]
        do {
            let result = try managedContext.fetch(taskSearch)
            self.tasks = result
        } catch let error as NSError {
            print("Error: \(error) description: \(error.localizedDescription)")
        }
    }
    
    func loadIncompleteTasks() {
        let taskSearch: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "project.name == %@ AND isDone == false", project.name)
        taskSearch.predicate = predicate
        do {
            print("all incomplete tasks")
            let result = try managedContext.fetch(taskSearch)
            for task in result {
                print(task.name)
            }
        } catch let error as NSError {
            print("Error: \(error) description: \(error.localizedDescription)")
        }
    }
    
    func loadCompletedTasks() {
        let taskSearch: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "project.name == %@ AND isDone == true", project.name)
        taskSearch.predicate = predicate
        do {
            print("all completed tasks")
            let result = try managedContext.fetch(taskSearch)
            for task in result {
                print(task.name)
            }
        } catch let error as NSError {
            print("Error: \(error) description: \(error.localizedDescription)")
        }
    }
}

extension ViewTasksController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ViewTasksController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2588235294, green: 1, blue: 0.262745098, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier) as! TaskCell
        let task = tasks[indexPath.row]
        let dueDate = task.dueDate.daysUntilDueDate()
        cell.setTitleAndDueDate(taskName: task.name, dueDate: dueDate)
        cell.doneButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        cell.doneButton.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
}
