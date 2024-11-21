//
//  TaskListRouter.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation
import UIKit

@objc protocol TaskListRoutingLogic {
  func routeToTaskDetails(segue: UIStoryboardSegue?)
  func routeToCreateTask(segue: UIStoryboardSegue?)
}

protocol TaskListDataPassing {
  var dataStore: TaskListDataStore? { get }
}

final class TaskListRouter: NSObject, TaskListRoutingLogic, TaskListDataPassing {
  
  weak var viewController: TaskListViewController?
  var dataStore: TaskListDataStore?
  
  // MARK: - Routing
  func routeToTaskDetails(segue: UIStoryboardSegue?) {
    guard let dataStore = dataStore else { return }
    
    if let segue = segue {
      guard let destinationVC = segue.destination as? TaskDetailsViewController else { return }
      guard var destinationDS = destinationVC.router?.dataStore else { return }
      passDataToTaskDetails(source: dataStore, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      guard let viewController = viewController else { return }
      guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "TaskDetailsViewController") as? TaskDetailsViewController else { return }
      guard var destinationDS = destinationVC.router?.dataStore else { return }
      passDataToTaskDetails(source: dataStore, destination: &destinationDS)
      navigateToTaskDetails(source: viewController, destination: destinationVC)
    }
  }
  
  func routeToCreateTask(segue: UIStoryboardSegue?) {
    if let segue = segue {
      guard let destinationVC = segue.destination as? CreateTaskViewController else { return }
      guard var destinationDS = destinationVC.router?.dataStore else { return }
      passDataToCreateTask(destination: &destinationDS)
    }
  }
  
  // MARK: - Navigation
  func navigateToTaskDetails(source: TaskListViewController, destination: TaskDetailsViewController) {
    source.show(destination, sender: nil)
  }
  
  // MARK: - Passing data
  func passDataToTaskDetails(source: TaskListDataStore, destination: inout TaskDetailsDataStore) {
    guard let indexPath = viewController?.tableView.indexPathForSelectedRow else { return }
    destination.task = source.tasks[indexPath.row]
  }
  
  func passDataToCreateTask(destination: inout CreateTaskDataStore) {
    destination.delegate = viewController
  }
}
