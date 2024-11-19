//
//  CreateTaskViewController.swift
//  ToDo list
//
//  Created by Ilyas on 19.11.2024.
//

import UIKit

final class CreateTaskViewController: UIViewController {
  
  @IBOutlet weak var breifDescriptionTF: UITextField!
  @IBOutlet weak var fullDescriptionTF: UITextField!
  
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  var delegate: CreateTaskViewControllerDelegate?
  
  private let storageManager = StorageManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  @IBAction func saveButtonPressed(_ sender: Any) {
    guard let breifDescription = breifDescriptionTF.text,
          let fullDescription = fullDescriptionTF.text else { return }
    
    storageManager.create(
      withBriefDescription: breifDescription,
      fullDescription: fullDescription,
      status: TaskStatus.new.rawValue,
      AndDate: Date.now) { [unowned self] task in
        delegate?.addTask(task)
      }
    
    navigationController?.popViewController(animated: true)
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
