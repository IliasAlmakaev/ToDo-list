//
//  TaskDetailsPresenter.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

protocol TaskDetailsPresentationLogic {
  func presentTaskDetails(response: TaskDetails.ShowDetails.Response)
}

final class TaskDetailsPresenter: TaskDetailsPresentationLogic {
  weak var viewController: TaskDetailsViewController?
  
  func presentTaskDetails(response: TaskDetails.ShowDetails.Response) {
    let status = "Статус: \(response.status ?? "")"
    let creationDate = "Дата создания: \(response.creationDate ?? "")"
    
    let viewModel = TaskDetails.ShowDetails.ViewModel(
      briefDescription: response.briefDescription ?? "",
      fullDescription: response.fullDescription ?? "",
      status: status,
      creationDate: creationDate
    )
    
    viewController?.displayTaskDetails(viewModel: viewModel)
  }
}
