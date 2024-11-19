//
//  ViewController.swift
//  ToDo list
//
//  Created by Ilyas on 19.11.2024.
//

import UIKit

class TaskListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  private var tasks: [Task] = []
  private let storageManager = StorageManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 110
    fetchData()
  }
  
  private func fetchData() {
    storageManager.fetchData { [unowned self] result in
      switch result {
      case .success(let tasks):
        self.tasks = tasks
      case .failure(let error):
        print(error.localizedDescription)
      }
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

