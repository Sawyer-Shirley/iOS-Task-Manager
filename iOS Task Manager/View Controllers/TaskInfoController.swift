//
//  TaskInfoController.swift
//  iOS Task Manager
//
//  Created by Sawyer Shirley on 11/27/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit

class TaskInfoController: UIViewController {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var detailsLabel: UITextView!
    
    var details = String()
    var name = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskName.text = name
        detailsLabel.text = details
    }
    
}
