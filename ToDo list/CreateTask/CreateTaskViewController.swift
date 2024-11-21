//
//  CreateTaskViewController.swift
//  ToDo list
//
//  Created by Ilyas on 19.11.2024.
//

import UIKit

protocol CreateTaskDisplayLogic: AnyObject {
  func backToTaskList()
}

final class CreateTaskViewController: UIViewController {
  
  @IBOutlet weak var breifDescriptionTF: UITextField!
  @IBOutlet weak var fullDescriptionTF: UITextField!
  
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  var interactor: CreateTaskBusinessLogic?
  var router: (NSObjectProtocol & CreateTaskRoutingLogic & CreateTaskDataPassing)?
  
  var delegate: CreateTaskViewControllerDelegate?
  
  // MARK: - Object lifecycle
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    CreateTaskConfigurator.shared.configure(with: self)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    CreateTaskConfigurator.shared.configure(with: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    view.endEditing(true)
  }
  
  @IBAction func saveButtonPressed(_ sender: Any) {
    guard let breifDescription = breifDescriptionTF.text,
          let fullDescription = fullDescriptionTF.text else { return }
    
    let request = CreateTask.Request(
      briefDescription: breifDescription,
      fullDescription: fullDescription,
      status: TaskStatus.new.rawValue,
      creationDate: Date.now
    )
    
    interactor?.createTask(request: request)
  }
  
  private func setupUI() {
    saveButton.isEnabled = false
    
    let textFieldAction = UIAction { [unowned self] _ in
      guard let breifDescription = breifDescriptionTF.text,
            let fullDescription = fullDescriptionTF.text else { return }
      
      saveButton.isEnabled = !breifDescription.isEmpty && !fullDescription.isEmpty
    }
    
    breifDescriptionTF.addAction(textFieldAction, for: .editingChanged)
    fullDescriptionTF.addAction(textFieldAction, for: .editingChanged)
  }
}

// MARK: - CreateTaskDisplayLogic
extension CreateTaskViewController: CreateTaskDisplayLogic {
  func backToTaskList() {
    router?.backToTaskList()
  }
}
