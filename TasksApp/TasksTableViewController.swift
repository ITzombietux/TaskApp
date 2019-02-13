//
//  TasksTableViewController.swift
//  TasksApp
//
//  Created by zombietux on 08/02/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController, TaskCellUpdating {

    lazy var tasks = {
        return Task.getAllTasks()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        tableView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellReuseIdentifier: "emptyCell")
      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == tasks.count {
            return tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        if let taskCell = cell as? TaskCell {
            let task = tasks[indexPath.row]
            
            taskCell.object = task
            taskCell.updatingDelegate = self
            
            taskCell.setText(task.text, completed: task.completed)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == tasks.count {
            onAddTaskTapped()
            return
        }
        
        let task = tasks[indexPath.row]
        task.setCompleted(!task.completed)
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        tableView.beginUpdates()
        
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            task.delete()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        tableView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < tasks.count
    }

    
    func onAddTaskTapped() {
        let task = Task.makePersistedTask()
        
        if task != nil {
            tableView.reloadData()
            
        if let cell = tableView.visibleCells.filter({ $0 is TaskCell }).last as? TaskCell {
                cell.beginEditing()
            }
        }
    }
    
    func onTextViewChanged(text: String, object: Any?) {
        if let task = object as? Task {
            task.setText(text)
        }
    }
}
