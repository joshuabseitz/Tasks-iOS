//
//  PersistenceController.swift
//  Tasks
//
//  Created by Josh on 10/9/20.
//  Copyright © 2020 Joshua Seitz. All rights reserved.
//

import Foundation
import CoreData

struct PersistenceController {
	
	static var container: NSPersistentContainer!
	
	static func save(_ task: Task) {
//		container.viewContext.insert(task)
		
		do {
			try container.viewContext.save()
		} catch {
			print(error)
		}
		
	}
	
	static func getAllTasks() -> [Task] {
		let taskFetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
		let taskResult = try! container.viewContext.fetch(taskFetchRequest)
		return taskResult
	}
	
	static func delete(_ task: Task) {
		container.viewContext.delete(task)
		try! container.viewContext.save()
		
	}
	
}
