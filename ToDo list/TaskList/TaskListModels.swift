//
//  TaskListModels.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

typealias TaskCellViewModel = TaskList.ShowTasks.ViewModel.TaskCellViewModel

enum TaskStatus: String {
  case new = "Новая"
  case atWork = "В работе"
  case done = "Выполнена"
}

protocol TaskCellViewModelProtocol {
  var identifier: String { get }
  var height: Double { get }
  var briefDescription: String { get }
  var status: String { get }
  var creationDate: String { get }
  var isNotDoneStatus: Bool { get }
  var task: Task { get }
  var delegate: TaskCellDelegate? { get set }
  init(task: Task)
}

enum TaskList {
  
  // MARK: - User cases
  enum ShowTasks {
    
    struct Response {
      let tasks: [Task]
    }
    
    struct ViewModel {
      struct TaskCellViewModel: TaskCellViewModelProtocol {
        var identifier: String {
          "TaskCell"
        }
        
        var height: Double {
          110
        }
        
        var briefDescription: String {
          task.briefDescription ?? ""
        }
        
        var status: String {
          "Статус: \(task.status ?? "")"
        }
        
        var creationDate: String {
          task.creationDate?.currentDate ?? ""
        }
        
        var isNotDoneStatus: Bool {
          task.status != TaskStatus.done.rawValue
        }
        
        var task: Task
        
        weak var delegate: TaskCellDelegate?
        
        init(task: Task) {
          self.task = task
        }
      }
      let rows: [TaskCellViewModelProtocol]
    }
  }
  
  enum DeleteTask {
    struct Request {
      let task: Task
    }
  }
  
  enum ChangeStatus {
    struct Request {
      let task: Task
      let status: String
    }
  }
}
