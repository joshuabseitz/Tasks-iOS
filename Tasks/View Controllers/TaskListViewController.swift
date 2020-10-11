//
//  ViewController.swift
//  Tasks
//
//  Created by Josh on 10/1/20.
//  Copyright © 2020 Joshua Seitz. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {
	
	// MARK: Properties
	var tasks = [Task]()
	
	// MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
	// MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tasks = PersistenceController.getAllTasks()
		tableView.reloadData()
	}
	
	// MARK: - IBActions
	
    @IBAction func didTapAdd() {
        
        let entryListViewController = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
		entryListViewController.delegate = self
		
        navigationController?.pushViewController(entryListViewController, animated: true)
    }
	
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			didDeleteTask(index: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = tasks[indexPath.row].text
        return cell
    }
	
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
        tableView.deselectRow(at: indexPath, animated: true)
        
        let taskViewController = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        taskViewController.title = "New Task"
		taskViewController.task = tasks[indexPath.row]
		taskViewController.taskText = tasks[indexPath.row].text
		taskViewController.row = indexPath.row
		taskViewController.delegate = self
        navigationController?.pushViewController(taskViewController, animated: true)
    }
}

extension TaskListViewController: EntryViewControllerDelegate {
	
	func didFinishCreatingTask(_ task: Task) {
		PersistenceController.save(task)
		tableView.reloadData()
	}
}

extension TaskListViewController: TaskViewControllerDelegate {
	
	func didDeleteTask(index: Int) {
		PersistenceController.delete(tasks[index])
//		tasks.remove(at: index)
		tasks = PersistenceController.getAllTasks()
		tableView.reloadData()
	}
}
