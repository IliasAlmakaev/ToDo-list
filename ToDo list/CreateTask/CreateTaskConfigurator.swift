//
//  CreateTaskConfigurator.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

final class CreateTaskConfigurator {
  static let shared = CreateTaskConfigurator()
  
  private init() {}
  
  func configure(with viewController: CreateTaskViewController) {
    let interactor = CreateTaskInteractor()
    let presenter = CreateTaskPresenter()
    let router = CreateTaskRouter()
    
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
}
