//
//  TaskDetailsConfigurator.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

final class TaskDetailsConfigurator {
  static let shared = TaskDetailsConfigurator()
  
  private init() {}
  
  func configure(with viewController: TaskDetailsViewController) {
    let interactor = TaskDetailsInteractor()
    let presenter = TaskDetailsPresenter()
    let router = TaskDetailsRouter()
    
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
}
