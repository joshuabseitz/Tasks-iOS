//
//  ViewController.swift
//  Tasks
//
//  Created by Josh on 10/1/20.
//  Copyright © 2020 Joshua Seitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	// MARK: Properties
	var tasks = [String]()

	
	// MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
	// MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        reloadTasks()
    }
	
	// MARK: - IBActions
	
    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        
		vc.update = {
            DispatchQueue.main.async {
                self.reloadTasks()
            }
        }
		
        navigationController?.pushViewController(vc, animated: true)
    }
	
	// MARK: - Convenience Methods
    
	/// This reloads the tasks in the view, including reloading the table view.
    func reloadTasks() {
        tasks.removeAll()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "New Task"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}
