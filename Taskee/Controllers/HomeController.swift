//
//  ViewController.swift
//  Taskee
//
//  Created by Anika Morris on 9/22/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class HomeController: UIViewController {
    
    //MARK: Properties
    var coordinator: AppCoordinator!
    var projects = [Project]()
    var managedContext: NSManagedObjectContext!
    
    //MARK: Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Projects"
        label.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.identifier)
        return tableView
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        loadProjects()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: NSNotification.Name(rawValue: "ProjectAdded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: NSNotification.Name(rawValue: "TaskAdded"), object: nil)

    }
    
    override func viewWillLayoutSubviews() {
        setupViews()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newProject))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshTableView()
    }

    //MARK: Methods
    func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(60)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(15)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func newProject(_ sender: UIBarButtonItem) {
        coordinator.goToNewProjectController()
    }
    
    @objc func refreshTableView() {
        loadProjects()
        tableView.reloadData()
    }
    
    func loadProjects() {
        let projectSearch: NSFetchRequest<Project> = Project.fetchRequest()
        do {
            let projects = try managedContext.fetch(projectSearch)
            if projects.count > 0 {
                self.projects = projects.reversed()
            }
        } catch let error as NSError {
            print("Error: \(error) description: \(error.localizedDescription)")
        }
    }

    func colorFromName(_ name: String) -> UIColor {
        for color in ColorComponents.allCases {
            switch color {
            default:
                if color.systemName == name {
                    return color.uiColor
                }
            }
        }
        return .systemGray
    }
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = projects[indexPath.row]
        coordinator.goToViewTasksController(project: project)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let project = projects[indexPath.row]
            managedContext.delete(project)
            do {
                try managedContext.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            refreshTableView()
        }
    }
}

extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectCell.identifier) as! ProjectCell
        let project = projects[indexPath.row]
        let color = ColorComponents.init(systemName: project.color)
        let colorFromName = color.uiColor
        // inefficient but i'm not tryna rewrite loadIncompleteTasks rn
        let allTasks = project.tasks!
        var numPendingTasks = 0
        if allTasks.count > 0 {
            for i in 0...allTasks.count-1 {
                let task = allTasks[i] as! Task
                if task.isDone == false {
                    numPendingTasks += 1
                }
            }
        }
        cell.setTitleAndTasksAndColor(projectTitle: project.name,
                                                    tasks: numPendingTasks,
                                                    color: colorFromName)
        return cell
    }
}
