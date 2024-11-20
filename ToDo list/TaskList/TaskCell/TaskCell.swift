//
//  TaskCell.swift
//  ToDo list
//
//  Created by Ilyas on 19.11.2024.
//

import UIKit

final class TaskCell: UITableViewCell {

  @IBOutlet weak var briefDescriptionLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  @IBOutlet weak var menuButton: UIButton!
  
  weak var delegate: TaskCellDelegate?
  var task: Task!
  
  func configure(withTask task: Task) {
    self.task = task
    
    briefDescriptionLabel.text = task.briefDescription
    statusLabel.text = "Статус: \(task.status ?? "")"
    dateLabel.text = task.creationDate?.currentDate
    
    menuButton.isEnabled = task.status != TaskStatus.done.rawValue
  }
  
  @IBAction func menuButtonPressed() {
    delegate?.showMenu(withTask: task, andCell: self)
  }
  
}
