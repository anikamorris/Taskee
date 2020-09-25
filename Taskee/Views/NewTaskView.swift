//
//  NewTaskView.swift
//  Taskee
//
//  Created by Anika Morris on 9/25/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class NewTaskView: UIView {
    
    //MARK: Properties
    let parentVC: NewTaskController
    
    //MARK: Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Task"
        label.font = UIFont(name: Constants.font, size: 30.0)
        label.textColor = .black
        return label
    }()
    let taskNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont(name: Constants.font, size: 17.0)
        label.textColor = .black
        return label
    }()
    let dueDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Due Date"
        label.font = UIFont(name: Constants.font, size: 17.0)
        label.textColor = .black
        return label
    }()
    let taskNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "e.g. Create repository"
        textField.font = UIFont(name: Constants.font, size: 30.0)
        return textField
    }()
    let dueDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "mm/dd/yyyy"
        textField.font = UIFont(name: Constants.font, size: 30.0)
        return textField
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.alignment = .leading
        return sv
    }()
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: Init
    init(frame: CGRect, title: String, parentVC: NewTaskController) {
        titleLabel.text = title
        self.parentVC = parentVC
        super.init(frame: frame)
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    fileprivate func createViews() {
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(60)
        }
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(20)
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.45)
            make.centerX.equalToSuperview()
        }
        stackView.addArrangedSubview(taskNameLabel)
        stackView.addArrangedSubview(taskNameTextField)
        stackView.addArrangedSubview(dueDateLabel)
        stackView.addArrangedSubview(dueDateTextField)
        self.addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        parentVC.coordinator.goBackToViewTasksController()
    }
}
