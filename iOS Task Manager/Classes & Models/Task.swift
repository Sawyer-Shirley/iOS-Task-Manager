//
//  Task.swift
//  iOS Task Manager
//
//  Created by Sawyer Shirley on 11/27/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import Foundation

let calendar = Calendar(identifier: .gregorian)
let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!

class Task {
    
    
    
    //Priority
    enum Priority: String {
        case priority = " * "
        case notPriority = "  "
    }
    
    //Marks if the task is complete or not
    enum Completion {
        case complete
        //Adds due date if task is incomplete
        case incomplete(dueDate: Date)
    }
    
    
    //Properties
    let taskName: String
    let details: String
    let priority: Priority
    var completion: Completion
    
    init(taskName: String, details: String, priority: Priority) {
        self.taskName = taskName
        self.details = details
        self.priority = priority
        self.completion = .incomplete(dueDate: dueDate)
    }
}
