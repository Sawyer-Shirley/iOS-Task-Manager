//
//  NewTaskController.swift
//  iOS Task Manager
//
//  Created by Sawyer Shirley on 11/28/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit

class NewTaskController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priorityControl: UISegmentedControl!
    @IBOutlet weak var taskDetails: UITextView!
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard
            let title = nameTextField.text, !title.isEmpty,
            let details = taskDetails.text, !details.isEmpty
            else {
                let errorAlert = UIAlertController(title: "Error", message: "Please make sure everything is filled out", preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) //When tapped this will dismiss the error alert
                errorAlert.addAction(errorAction)
                self.present(errorAlert, animated: true, completion: nil)
                return
    }
        saveTask()
}
    
    //Shows options for priority
    let segments: [(title: String, priority: Task.Priority)] =
        [("Yes", .priority),
         ("No", .notPriority)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        priorityControl.removeAllSegments()
        
        for (index, segment) in segments.enumerated() {
            priorityControl.insertSegment(withTitle: segment.title, at: index, animated: false)
        }
        
        priorityControl.selectedSegmentIndex = 0;
        
    }
    
    
    func saveTask() {
        
        //Title
        guard let title = nameTextField.text else { return
            
        }


        //Details
        guard let details = taskDetails.text else { return
            
        }

        //Priority
        let priority = segments[priorityControl.selectedSegmentIndex].priority

        let task = Task(taskName: title, details: details, priority: priority)

        //Adds new task to the array
        TaskLibrary.sharedInstance.tasks.append(task)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
