//
//  CreateTaskRouter.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

@objc protocol CreateTaskRoutingLogic {
  func backToTaskList()
}

protocol CreateTaskDataPassing {
  var dataStore: CreateTaskDataStore? { get }
}

class CreateTaskRouter: NSObject, CreateTaskRoutingLogic, CreateTaskDataPassing {
  
  weak var viewController: CreateTaskViewController?
  var dataStore: CreateTaskDataStore?
  
  func backToTaskList() {
    viewController?.navigationController?.popViewController(animated: true)
  }
}
