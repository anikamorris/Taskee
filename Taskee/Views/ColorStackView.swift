//
//  ColorStackView.swift
//  Taskee
//
//  Created by Anika Morris on 9/24/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ColorStackView: UIStackView {
    
    //MARK: Properties
    let color1: UIColor
    let color2: UIColor
    let color3: UIColor
    
    //MARK: Subviews
    let firstButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        return button
    }()
    
    let secondButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        return button
    }()
    
    let thirdButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        return button
    }()
    
    //MARK: Init
    init(frame: CGRect, color1: UIColor, color2: UIColor, color3: UIColor) {
        self.color1 = color1
        self.color2 = color2
        self.color3 = color3
        super.init(frame: frame)
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    fileprivate func setupStackView() {
        // stack view set up
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.alignment = .center
        // set image view colors
        firstButton.backgroundColor = color1
        secondButton.backgroundColor = color2
        thirdButton.backgroundColor = color3
        // image view set up
        self.addArrangedSubview(firstButton)
        firstButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
        }
        self.addArrangedSubview(secondButton)
        secondButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
        }
        self.addArrangedSubview(thirdButton)
        thirdButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
        }
    }
    
    func removeButtonBorders() {
        firstButton.layer.borderWidth = 0
        secondButton.layer.borderWidth = 0
        thirdButton.layer.borderWidth = 0
    }
}
