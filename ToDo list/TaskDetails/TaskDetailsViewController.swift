//
//  TaskDetailsViewController.swift
//  ToDo list
//
//  Created by Ilyas on 19.11.2024.
//

import UIKit

class TaskDetailsViewController: UIViewController {
  
  @IBOutlet weak var briefDescriptionLabel: UILabel!
  @IBOutlet weak var fullDescriptionLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  var task: Task!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    briefDescriptionLabel.text = task.briefDescription
    fullDescriptionLabel.text = task.fullDescription
    statusLabel.text = "Статус: \(task.status ?? "")"
    dateLabel.text = task.creationDate?.currentDate
  }
}
