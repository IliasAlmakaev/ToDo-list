//
//  TaskDetailsViewController.swift
//  ToDo list
//
//  Created by Ilyas on 19.11.2024.
//

import UIKit

protocol TaskDetailsDisplayLogic: AnyObject {
  func displayTaskDetails(viewModel: TaskDetails.ShowDetails.ViewModel)
}

final class TaskDetailsViewController: UIViewController {
  
  @IBOutlet weak var briefDescriptionLabel: UILabel!
  @IBOutlet weak var fullDescriptionLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  var task: Task!
  var interactor: TaskDetailsBusinessLogic?
  var router: (NSObjectProtocol & TaskDetailsRoutingLogic & TaskDetailsDataPassing)?
  
  // MARK: - Object lifecycle
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    TaskDetailsConfigurator.shared.configure(with: self)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    TaskDetailsConfigurator.shared.configure(with: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    passRequest()
  }
  
  private func passRequest() {
    interactor?.provideTaskDetails()
  }
}

// MARK: - TaskDetailsDisplayLogic
extension TaskDetailsViewController: TaskDetailsDisplayLogic {
  func displayTaskDetails(viewModel: TaskDetails.ShowDetails.ViewModel) {
    briefDescriptionLabel.text = viewModel.briefDescription
    fullDescriptionLabel.text = viewModel.fullDescription
    statusLabel.text = viewModel.status
    dateLabel.text = viewModel.creationDate
  }
}
