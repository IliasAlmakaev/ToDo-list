//
//  TaskCell.swift
//  ToDo list
//
//  Created by Ilyas on 19.11.2024.
//

import UIKit

protocol CellModelRepresentable {
  var viewModel: TaskCellViewModelProtocol? { get }
}

final class TaskCell: UITableViewCell, CellModelRepresentable {

  @IBOutlet weak var briefDescriptionLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  @IBOutlet weak var menuButton: UIButton!
  
  var viewModel: TaskCellViewModelProtocol? {
    didSet {
      updateView()
    }
  }
  
  weak var delegate: TaskCellDelegate?
  var task: Task!
  
  private func updateView() {
    guard let viewModel = viewModel as? TaskCellViewModel else { return }

    briefDescriptionLabel.text = viewModel.briefDescription
    statusLabel.text = viewModel.status
    dateLabel.text = viewModel.creationDate
    
    menuButton.isEnabled = viewModel.isNotDoneStatus
    delegate = viewModel.delegate
  }
  
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
