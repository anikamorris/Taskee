//
//  TaskCell.swift
//  Taskee
//
//  Created by Anika Morris on 9/24/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TaskCell: UITableViewCell {
    
    //MARK: Properties
    static let identifier = "TaskCell"
    
    //MARK: Subviews
    let taskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.font, size: 18.0)
        return label
    }()
    
    let dueDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: Constants.font, size: 12.0)
        return label
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.borderColor = CGColor.init(red: 66, green: 255, blue: 27, alpha: 1)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    fileprivate func createSubviews() {
        self.contentView.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
            make.left.equalToSuperview().offset(8)
        }
        self.addSubview(labelStackView)
        labelStackView.snp.makeConstraints { (make) in
            make.left.equalTo(doneButton.snp_rightMargin).offset(20)
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerY.equalToSuperview()
        }
        labelStackView.addArrangedSubview(taskLabel)
        labelStackView.addArrangedSubview(dueDateLabel)
    }
    
    func setTitleAndDueDate(taskName: String, dueDate: String) {
        setTitle(taskName: taskName)
        setDueDate(dueDate: dueDate)
    }
    
    func setTitle(taskName: String) {
        taskLabel.text = taskName
    }
    
    func setDueDate(dueDate: String) {
        dueDateLabel.text = dueDate
    }
}
