//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Anika Morris on 10/3/20.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var dueDate: Date
    @NSManaged public var name: String
    @NSManaged public var project: Project

}
