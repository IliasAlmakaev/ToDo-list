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
  
  private func updateView() {
    guard let viewModel = viewModel as? TaskCellViewModel else { return }

    briefDescriptionLabel.text = viewModel.briefDescription
    statusLabel.text = viewModel.status
    dateLabel.text = viewModel.creationDate
    
    menuButton.isEnabled = viewModel.isNotDoneStatus
    delegate = viewModel.delegate
  }
  
  @IBAction func menuButtonPressed() {
    delegate?.showMenu(withTask: viewModel?.task ?? Task(), andCell: self)
  }
}
