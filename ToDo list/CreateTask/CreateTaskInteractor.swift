//
//  CreateTaskInteractor.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

protocol CreateTaskBusinessLogic {
  func createTask(request: CreateTask.Request)
}

protocol CreateTaskDataStore {
  var delegate: CreateTaskViewControllerDelegate? { get set }
}

class CreateTaskInteractor: CreateTaskBusinessLogic, CreateTaskDataStore {
  
  var presenter: CreateTaskPresentationLogic?
  weak var delegate: CreateTaskViewControllerDelegate?
  private let storageManager = StorageManager.shared
  
  func createTask(request: CreateTask.Request) {
    storageManager.create(
      withBriefDescription: request.briefDescription,
      fullDescription: request.fullDescription,
      status: request.status,
      AndDate: request.creationDate) { [unowned self] task in
        delegate?.addTask(task)
        presenter?.backToTaskList()
      }
  }
}
