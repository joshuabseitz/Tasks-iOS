//
//  EntryViewController.swift
//  Tasks
//
//  Created by Josh on 10/1/20.
//  Copyright © 2020 Joshua Seitz. All rights reserved.
//

import UIKit

protocol EntryViewControllerDelegate: class {
	func didFinishCreatingTask(_ task: String)
}

class EntryViewController: UIViewController {
	
	weak var delegate: EntryViewControllerDelegate?

    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
        textField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
															style: .done,
															target: self,
															action: #selector(saveTask))
    }
    
    @objc func saveTask() {
		// Dev note: objc allows it to be used as a selector
        
        guard let text = textField.text, !text.isEmpty else {
			print("Could not find text to create task.")
            return
        }
        
		delegate?.didFinishCreatingTask(text)
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension EntryViewController: UITextFieldDelegate {
	
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return false
    }
}
