//
//  ColorComponents.swift
//  Taskee
//
//  Created by Anika Morris on 10/5/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

enum ColorComponents: CaseIterable {
    case red, pink, orange, teal, green, yellow, purple, blue, indigo
    
    init(greenComponent: CGFloat) {
        switch greenComponent {
        case 0.23137254901960785:
            self = .red
        case 0.17647058823529413:
            self = .pink
        case 0.5843137254901961:
            self = .orange
        case 0.7843137254901961:
            self = .teal
        case 0.7803921568627451:
            self = .green
        case 0.8:
            self = .yellow
        case 0.3215686274509804:
            self = .purple
        case 0.47843137254901963:
            self = .blue
        case 0.33725490196078434:
            self = .indigo
        default:
            self = .blue
        }
    }
    
    init(systemName: String) {
        switch systemName {
        case "systemRed":
            self = .red
        case "systemPink":
            self = .pink
        case "systemOrange":
            self = .orange
        case "systemTeal":
            self = .teal
        case "systemGreen":
            self = .green
        case "systemYellow":
            self = .yellow
        case "systemPurple":
            self = .purple
        case "systemBlue":
            self = .blue
        case "systemIndigo":
            self = .indigo
        default:
            self = .blue
        }
    }
    
    var systemName: String {
        switch self {
        case .red:
            return "systemRed"
        case .pink:
            return "systemPink"
        case .orange:
            return "systemOrange"
        case .teal:
            return "systemTeal"
        case .green:
            return "systemGreen"
        case .yellow:
            return "systemYellow"
        case .purple:
            return "systemPurple"
        case .blue:
            return "systemBlue"
        case .indigo:
            return "systemIndigo"
        }
    }
        
    var greenComponent: CGFloat {
        switch self {
        case .red:
            return 0.23137254901960785
        case .pink:
            return 0.17647058823529413
        case .orange:
            return 0.5843137254901961
        case .teal:
            return 0.7843137254901961
        case .green:
            return 0.7803921568627451
        case .yellow:
            return 0.8
        case .purple:
            return 0.3215686274509804
        case .blue:
            return 0.47843137254901963
        case .indigo:
            return 0.33725490196078434
        }
    }
    
    var uiColor: UIColor {
        switch self {
        case .red:
            return .systemRed
        case .pink:
            return .systemPink
        case .orange:
            return .systemOrange
        case .teal:
            return .systemTeal
        case .green:
            return .systemGreen
        case .yellow:
            return .systemYellow
        case .purple:
            return .systemPurple
        case .blue:
            return .systemBlue
        case .indigo:
            return .systemIndigo
        }
    }
}

