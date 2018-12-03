//
//  TasksController.swift
//  iOS Task Manager
//
//  Created by Sawyer Shirley on 11/26/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit
import DZNEmptyDataSet


class TasksController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
        let library = TaskLibrary.sharedInstance
    
    
    override func  viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        
        //Removing the cell separators
        tableView.tableFooterView = UIView()
        
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    //Transfering the task info from library screen to Task Info screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTaskInfo" {
            
            let indexPath = self.tableView!.indexPathsForSelectedRows!.first!
            let task = library.tasks[indexPath.row]
            let vc = segue.destination as! TaskInfoController
            vc.details = task.details
            vc.name = task.taskName
            
        }
    }
    
    
}





//Creates table view
extension TasksController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.tasks.count
    }
    
    //Creating a new cell based on info added
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! CellModel
        
        let task = library.tasks[indexPath.row]
        cell.setup(task: task)
        
        return cell
    }
    
    //Marking task as incomplete
    func incomplete(at indexPath: IndexPath) {
        let task = self.library.tasks[indexPath.row]
        
        let calendar = Calendar(identifier: .gregorian)
        let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!
        
        task.completion = .incomplete(dueDate: dueDate)
        (tableView.cellForRow(at: indexPath) as! CellModel).setup(task: task)
    }
    
    //Marking task as complete
    func complete(at indexPath: IndexPath) {
        let task = self.library.tasks[indexPath.row]
        task.completion = .complete
        (tableView.cellForRow(at: indexPath) as! CellModel).setup(task: task)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Deleting Tasks
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            TaskLibrary.sharedInstance.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        
        let task = library.tasks[indexPath.row]
        
        //Adding the ability to swipe left on a cell to mark it as completed/incomplete or delete it
        switch task.completion {
        case .complete:
            let markIncompleteAction = UITableViewRowAction(style: .normal, title: "Incomplete?") { _, indexPath in
                
                self.incomplete(at: indexPath)
                
            }
            
            return [deleteAction, markIncompleteAction]
            
        case .incomplete:
            let markCompleteAction = UITableViewRowAction(style: .normal, title: "Finished?") { _, indexPath in
                self.complete(at: indexPath)
            }
            
            return [deleteAction, markCompleteAction]
            
        }
    }
}





//Shows a special screen when there are no cells
extension TasksController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    //Creates title for empty library screen
    func title(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "You have no tasks."
        
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 195/255, blue: 195/255, alpha:1.0)]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    //Gives user more information
    func description(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "Get poppin' and add some!"
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0), NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 195/255, blue: 195/255, alpha:1.0), NSAttributedString.Key.paragraphStyle: paragraph]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    //Labels button for the empty screen
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView?, for state: UIControl.State) -> NSAttributedString? {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
        
        return NSAttributedString(string: "Add Task", attributes: attributes)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView?) -> UIColor? {
        return UIColor(red: 146/255, green: 245/255, blue: 255/255, alpha:1.0)
    }
    
    //Sends user to add a task when the button on empty library is pressed
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        performSegue(withIdentifier: "tasksToCreate", sender: self)
    }
}

