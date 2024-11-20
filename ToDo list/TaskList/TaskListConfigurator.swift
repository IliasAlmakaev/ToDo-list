//
//  TaskListConfigurator.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

final class TaskListConfigurator {
  static let shared = TaskListConfigurator()
  
  private init() {}
  
  func configure(with viewController: TaskListViewController) {
    let interactor = TaskListInteractor()
    let presenter = TaskListPresenter()
    let router = TaskListRouter()
    
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
}
