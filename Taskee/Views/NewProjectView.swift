//
//  NewProjectView.swift
//  Taskee
//
//  Created by Anika Morris on 9/24/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class NewProjectView: UIView {
    
    //MARK: Properties
    let colors: [UIColor]
    let parentVC: NewProjectController
    
    //MARK: Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Project"
        label.font = UIFont(name: Constants.font, size: 30.0)
        var font = label.font
        label.font = font?.withWeight(.bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: Constants.font, size: 27.0)
        textField.placeholder = "Project Name"
        textField.textAlignment = .center
        textField.layer.borderWidth = 0
        return textField
    }()
    let colorsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    init(frame: CGRect, colors: [UIColor], parentVC: NewProjectController) {
        self.colors = colors
        self.parentVC = parentVC
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(60)
        }
        self.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(15)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(60)
        }
        self.addSubview(colorsStackView)
        colorsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextField.snp_bottomMargin).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(self.frame.width).multipliedBy(0.8)
        }
        let firstStackView = ColorStackView.init(frame: .zero,
                                                color1: colors[0],
                                                color2: colors[1],
                                                color3: colors[2])
        let secondStackView = ColorStackView.init(frame: .zero,
                                                color1: colors[3],
                                                color2: colors[4],
                                                color3: colors[5])
        let thirdStackView = ColorStackView.init(frame: .zero,
                                                color1: colors[6],
                                                color2: colors[7],
                                                color3: colors[8])
        colorsStackView.addArrangedSubview(firstStackView)
        firstStackView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        colorsStackView.addArrangedSubview(secondStackView)
        secondStackView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        colorsStackView.addArrangedSubview(thirdStackView)
        thirdStackView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        self.addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
