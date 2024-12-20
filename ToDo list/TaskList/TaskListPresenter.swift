//
//  TaskListPresenter.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

protocol TaskListPresentaionLogic {
  func presentTasks(response: TaskList.ShowTasks.Response)
  func presentTask(response: TaskList.ShowTask.Response)
}

final class TaskListPresenter: TaskListPresentaionLogic {
  
  weak var viewController: TaskListDisplayLogic?
  
  func presentTasks(response: TaskList.ShowTasks.Response) {
    let rows: [TaskCellViewModelProtocol] = response.tasks.map {
      TaskCellViewModel(task: $0)
    }
    let viewModel = TaskList.ShowTasks.ViewModel(rows: rows)
    viewController?.displayTasks(viewModel: viewModel)
  }
  
  func presentTask(response: TaskList.ShowTask.Response) {
    let taskCell = TaskCellViewModel(task: response.task)
    let viewModel = TaskList.ShowTask.ViewModel(taskCell: taskCell)
    viewController?.displayTask(viewModel: viewModel)
  }
}
