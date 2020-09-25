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

class NewTaskController: UIViewController {
    
    //MARK: Properties
    var coordinator: AppCoordinator!
    var task: String?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = task {
            self.view = NewTaskView.init(frame: .zero, title: "Edit Task", parentVC: self)
        } else {
            self.view = NewTaskView.init(frame: .zero, title: "New Task", parentVC: self)
        }
    }
    //MARK: Methods
}
