//
//  NewProjectController.swift
//  Taskee
//
//  Created by Anika Morris on 9/24/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

class NewProjectController: UIViewController {
    
    //MARK: Properties
    var coordinator: AppCoordinator!
    let colors: [UIColor] = [#colorLiteral(red: 0.9098039269, green: 0.3330472975, blue: 0.5860706679, alpha: 1), #colorLiteral(red: 0.8538321424, green: 0.4087919683, blue: 0.9098039269, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.5480576569, blue: 0.2224305041, alpha: 1), #colorLiteral(red: 0.268188586, green: 0.9686274529, blue: 0.9183855196, alpha: 1), #colorLiteral(red: 0.4085487479, green: 0.9764705896, blue: 0.5838560058, alpha: 1), #colorLiteral(red: 1, green: 0.9416184506, blue: 0.4017597648, alpha: 1), #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = NewProjectView.init(frame: view.frame,
                                        colors: colors,
                                        parentVC: self)
        let newProjectView = self.view as! NewProjectView
        let saveButton = newProjectView.saveButton
        saveButton.addTarget(self, action: #selector(saveProject), for: .touchUpInside)
    }
    
    @objc func saveProject(_ sender: UIBarButtonItem) {
        coordinator.goBackToHomeController()
    }
}
