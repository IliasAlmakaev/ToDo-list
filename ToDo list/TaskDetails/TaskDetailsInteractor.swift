//
//  TaskDetailsInteractor.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

protocol TaskDetailsBusinessLogic {
  func provideTaskDetails()
}

protocol TaskDetailsDataStore {
  var task: Task? { get set }
}

final class TaskDetailsInteractor: TaskDetailsBusinessLogic, TaskDetailsDataStore {
  var task: Task?
  var presenter: TaskDetailsPresentationLogic?
  
  func provideTaskDetails() {
    let response = TaskDetails.ShowDetails.Response(
      briefDescription: task?.briefDescription,
      fullDescription: task?.fullDescription,
      status: task?.status,
      creationDate: task?.creationDate?.currentDate
    )
    presenter?.presentTaskDetails(response: response)
  }
}
