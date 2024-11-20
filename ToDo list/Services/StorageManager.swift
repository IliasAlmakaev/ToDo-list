//
//  StorageManager.swift
//  ToDo list
//
//  Created by Ilyas on 19.11.2024.
//

import Foundation
import CoreData

final class StorageManager {
  static let shared = StorageManager()
  
  // MARK: - Core Data stack
  private let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ToDo_list")
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  private let viewContext: NSManagedObjectContext
  
  private init() {
    viewContext = persistentContainer.viewContext
  }
  
  // MARK: - CRUD
  func create(
    withBriefDescription briefDescription: String,
    fullDescription: String,
    status: String,
    AndDate date: Date,
    completion: @escaping (Task) -> Void
  ) {
    
    let task = Task(context: viewContext)
    
    task.briefDescription = briefDescription
    task.fullDescription = fullDescription
    task.status = status
    task.creationDate = date
    completion(task)
    saveContext()
  }
  
  func changeStatus(_ task: Task, newStatus: String) {
    task.status = newStatus
    saveContext()
  }
  
  func fetchData(completion: (Result<[Task], Error>) -> Void) {
    let fetchRequest = Task.fetchRequest()
    
    do {
      let tasks = try viewContext.fetch(fetchRequest)
      completion(.success(tasks))
    } catch let error {
      completion(.failure(error))
    }
  }
  
  func delete(_ task: Task) {
    viewContext.delete(task)
    saveContext()
  }
  
  // MARK: - Core Data Saving support
  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
}
