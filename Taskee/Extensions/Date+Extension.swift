//
//  Date+Extension.swift
//  Taskee
//
//  Created by Anika Morris on 10/6/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

extension Date {
    func daysUntilDueDate() -> String {
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: self)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        guard let day = components.day else { return "" }
        if day < 0 {
            return "0 days left"
        }
        return "\(day) days left"
    }
}
