//
//  ViewController.swift
//  ToDo list
//
//  Created by Ilyas on 19.11.2024.
//

import UIKit

protocol CreateTaskViewControllerDelegate: AnyObject {
  func addTask(_ task: Task)
}

class TaskListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  private var tasks: [Task] = []
  private let storageManager = StorageManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 110
    fetchData()
  }
  
  internal func fetchData() {
    storageManager.fetchData { [unowned self] result in
      switch result {
      case .success(let tasks):
        self.tasks = tasks
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "TaskDetails" {
      guard let taskDetailsVC = segue.destination as? TaskDetailsViewController else { return }
      guard let indexPath = tableView.indexPathForSelectedRow else { return }
      
      let task = tasks[indexPath.row]
      taskDetailsVC.task = task
    } else {
      guard let createTaskVC = segue.destination as? CreateTaskViewController else { return }
      createTaskVC.delegate = self
    }
  }
}

// MARK: - UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
    guard let cell = cell as? TaskCell else { return UITableViewCell() }
    
    let task = tasks[indexPath.row]
    cell.configure(withTask: task)
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension TaskListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let task = tasks.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      storageManager.delete(task)
    }
  }
}

extension TaskListViewController: CreateTaskViewControllerDelegate {
  func addTask(_ task: Task) {
    tasks.append(task)
    tableView.reloadData()
  }
}

