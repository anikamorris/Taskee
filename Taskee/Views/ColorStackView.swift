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
    let firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let thirdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
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
        firstImageView.backgroundColor = color1
        secondImageView.backgroundColor = color2
        thirdImageView.backgroundColor = color3
        // image view set up
        self.addArrangedSubview(firstImageView)
        firstImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
        }
        self.addArrangedSubview(secondImageView)
        secondImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
        }
        self.addArrangedSubview(thirdImageView)
        thirdImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
        }
    }
}
