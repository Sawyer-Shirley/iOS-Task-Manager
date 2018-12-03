//
//  TaskLibrary.swift
//  iOS Task Manager
//
//  Created by Sawyer Shirley on 11/27/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import Foundation

class TaskLibrary {
    
    static let sharedInstance = TaskLibrary()
    
    var tasks = [Task]()
    
}
