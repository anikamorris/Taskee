//
//  ProjectCell.swift
//  Taskee
//
//  Created by Anika Morris on 9/22/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ProjectCell: UITableViewCell {
    
    //MARK: Properties
    static let identifier = "ProjectCell"
    
    //MARK: Subviews
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    let projectLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: Constants.font, size: 20.0)
        return label
    }()
    
    let tasksPendingLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: Constants.font, size: 14.0)
        return label
    }()
    
    let colorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
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
        self.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        container.addSubview(colorImage)
        colorImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.width.equalTo(30)
        }
        container.addSubview(projectLabel)
        projectLabel.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(colorImage.snp_rightMargin).offset(15)
        }
    }
    
    func setTitleAndColor(projectTitle: String, color: UIColor) {
        projectLabel.text = projectTitle
        colorImage.backgroundColor = color
    }
}
