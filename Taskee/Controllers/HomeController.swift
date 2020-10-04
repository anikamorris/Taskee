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
    }
    
    override func viewWillLayoutSubviews() {
        setupViews()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newProject))
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

}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = projects[indexPath.row]
        coordinator.goToViewTasksController(project: project)
    }
}

extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectCell.identifier) as! ProjectCell
        let project = projects[indexPath.row]
        cell.setTitleAndColor(projectTitle: project.name, color: UIColor(named: project.color)!)
        return cell
    }
    
    
}
