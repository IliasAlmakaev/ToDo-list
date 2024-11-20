//
//  TaskListInteractor.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

protocol TaskListBusinessLogic {
  func fetchTasks()
  func deleteTask(request: TaskList.DeleteTask.Request)
  func changeStatus(request: TaskList.ChangeStatus.Request)
}

protocol TaskListDataStore {
  var tasks: [Task] { get }
}

final class TaskListInteractor: TaskListBusinessLogic, TaskListDataStore {
  
  var presenter: TaskListPresentaionLogic?
  var tasks: [Task] = []
  private let storageManager = StorageManager.shared
  
  func fetchTasks() {
    StorageManager.shared.fetchData { [weak self] result in
      switch result {
      case .success(let tasks):
        self?.tasks = tasks
        let response = TaskList.ShowTasks.Response(tasks: tasks)
        self?.presenter?.presentTasks(response: response)
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func deleteTask(request: TaskList.DeleteTask.Request) {
    storageManager.delete(request.task)
  }
  
  func changeStatus(request: TaskList.ChangeStatus.Request) {
    storageManager.changeStatus(request.task, newStatus: request.status)
  }
}
