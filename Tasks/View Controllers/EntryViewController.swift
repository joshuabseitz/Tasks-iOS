//
//  EntryViewController.swift
//  Tasks
//
//  Created by Josh on 10/1/20.
//  Copyright © 2020 Joshua Seitz. All rights reserved.
//

import UIKit

protocol EntryViewControllerDelegate: class {
	func didFinishCreatingTask(_ task: Task)
}

class EntryViewController: UIViewController {
	
	weak var delegate: EntryViewControllerDelegate?
	
	@IBOutlet weak var taskTitleTextView: UITextView!
	@IBOutlet weak var taskDescriptionTextView: UITextView!
	@IBOutlet weak var taskValueTextView: UITextView!
	
    override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "New Task"
		taskTitleTextView.delegate = self
		
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
															style: .done,
															target: self,
															action: #selector(saveTask))
		
		// taskTitleTextView Properties
		taskTitleTextView.layer.cornerRadius = 5.0
		taskTitleTextView.layer.borderColor = UIColor.black.cgColor
		taskTitleTextView.layer.borderWidth = 0.75
		taskTitleTextView.textContainerInset = UIEdgeInsets(top: 10,left: 5,bottom: 10,right: 5); // top, left, bottom, right
		
		// taskDescriptionTextView Properties
		taskDescriptionTextView.layer.cornerRadius = 5.0
		taskDescriptionTextView.layer.borderColor = UIColor.black.cgColor
		taskDescriptionTextView.layer.borderWidth = 0.75
		taskDescriptionTextView.textContainerInset = UIEdgeInsets(top: 10,left: 5,bottom: 10,right: 5); // top, left, bottom, right
		
		// taskValueTextView Properties
		taskValueTextView.layer.cornerRadius = 5.0
		taskValueTextView.layer.borderColor = UIColor.black.cgColor
		taskValueTextView.layer.borderWidth = 0.75
		taskValueTextView.textContainerInset = UIEdgeInsets(top: 10,left: 5,bottom: 10,right: 5); // top, left, bottom, right
		
    }
    
    @objc func saveTask() {
		// Dev note: objc allows it to be used as a selector
        
        guard let taskTitle = taskTitleTextView.text, !taskTitle.isEmpty else {
			print("Could not find task title.")
            return
        }
		
//		guard let taskValue = taskValueTextView.text, !taskValue.isEmpty else {
//				   print("Could not find task value.")
//				   return
//	    }
		
		guard let taskDescription = taskDescriptionTextView.text, !taskDescription.isEmpty else {
				   print("Could not find description.")
				   return
	    }
		
		let task = Task(context: PersistenceController.container.viewContext)
		
		task.text = taskTitle
		task.descrip = taskDescription
//		task.value = taskValue
		task.dateCreated = Date()
		task.completed = false
		
		print("Created task: \(task)")
		delegate?.didFinishCreatingTask(task)

        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextViewDelegate

extension EntryViewController: UITextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		textView.text = ""
	}

}
