//
//  TaskListInteractor.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

protocol TaskListBusinessLogic {
  func fetchTasks()
}

protocol TaskListDataStore {
  var tasks: [Task] { get }
}

final class TaskListInteractor: TaskListBusinessLogic, TaskListDataStore {
  
  var presenter: TaskListPresentaionLogic?
  var tasks: [Task] = []
  
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
}
