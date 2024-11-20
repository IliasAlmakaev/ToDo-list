//
//  TaskDetailsRouter.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

@objc protocol TaskDetailsRoutingLogic {
  
}

protocol TaskDetailsDataPassing {
  var dataStore: TaskDetailsDataStore? { get }
}

final class TaskDetailsRouter: NSObject, TaskDetailsRoutingLogic, TaskDetailsDataPassing {
  
  weak var viewController: TaskDetailsViewController?
  var dataStore: TaskDetailsDataStore?
}
