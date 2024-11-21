//
//  CreateTaskPresenter.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

protocol CreateTaskPresentationLogic {
  func backToTaskList()
}

class CreateTaskPresenter: CreateTaskPresentationLogic {
  
  weak var viewController: CreateTaskDisplayLogic?
  
  func backToTaskList() {
    viewController?.backToTaskList()
  }
}
