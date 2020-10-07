//
//  TaskViewController.swift
//  Tasks
//
//  Created by Josh on 10/1/20.
//  Copyright © 2020 Joshua Seitz. All rights reserved.
//

import UIKit

protocol TaskViewControllerDelegate {
	func didDeleteTask(index: Int)
}

class TaskViewController: UIViewController {

    var task: String?
	var row: Int?
	var delegate: TaskViewControllerDelegate?
	
	@IBOutlet var label: UILabel!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		label.text = task
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete",
															style: .done,
															target: self,
															action: #selector(deleteTask))
	}
	
	@objc func deleteTask() {
		delegate?.didDeleteTask(index: row!)
		navigationController?.popViewController(animated: true)
	}
}
