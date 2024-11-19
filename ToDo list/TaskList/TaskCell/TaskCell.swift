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
  
  func configure(withTask task: Task) {
    briefDescriptionLabel.text = task.briefDescription
    statusLabel.text = "Статус: \(task.status ?? "")"
    dateLabel.text = task.creationDate?.currentDate
  }
  
  @IBAction func menuButtonPressed() {
  }
  
}
