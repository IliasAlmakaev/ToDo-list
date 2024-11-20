//
//  ViewController.swift
//  ToDo list
//
//  Created by Ilyas on 19.11.2024.
//

import UIKit

protocol TaskListDisplayLogic: AnyObject {
  func displayTasks(viewModel: TaskList.ShowTasks.ViewModel)
}

protocol CreateTaskViewControllerDelegate: AnyObject {
  func addTask(_ task: Task)
}

protocol TaskCellDelegate: AnyObject {
  func showMenu(withTask task: Task, andCell: TaskCell)
}

class TaskListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var interactor: TaskListBusinessLogic?
  var router: (NSObjectProtocol & TaskListRoutingLogic & TaskListDataPassing)?
  
  private var tasks: [Task] = []
  private let storageManager = StorageManager.shared
  private var rows: [TaskCellViewModelProtocol] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    TaskListConfigurator.shared.configure(with: self)
    showTasks()
  }
  
  // MARK: - Routing
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
    
//    if segue.identifier == "TaskDetails" {
//      guard let taskDetailsVC = segue.destination as? TaskDetailsViewController else { return }
//      guard let indexPath = tableView.indexPathForSelectedRow else { return }
//
//      let task = tasks[indexPath.row]
//      taskDetailsVC.task = task
//    } else {
//      guard let createTaskVC = segue.destination as? CreateTaskViewController else { return }
//      createTaskVC.delegate = self
//    }
  }
  
  private func showTasks() {
    interactor?.fetchTasks()
  }
  
  private func deleteTask(withIndexPath indexPath: IndexPath) {
    let task = rows.remove(at: indexPath.row).task
    tableView.deleteRows(at: [indexPath], with: .automatic)
    let request = TaskList.ShowTasks.Request(task: task)
    
    interactor?.deleteTask(request: request)
  }
}

// MARK: - UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    rows.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellViewModel = rows[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath)
    guard let cell = cell as? TaskCell else { return UITableViewCell() }
    cell.viewModel = cellViewModel
    return cell
  }
}

// MARK: - UITableViewDelegate
extension TaskListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    rows[indexPath.row].height
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      deleteTask(withIndexPath: indexPath)
    }
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    rows[indexPath.row].isNotDoneStatus
  }
}

// MARK: - CreateTaskViewControllerDelegate
extension TaskListViewController: CreateTaskViewControllerDelegate {
  func addTask(_ task: Task) {
    tasks.append(task)
    tableView.reloadData()
  }
}

// MARK: - TaskCellDelegate
extension TaskListViewController: TaskCellDelegate {
  func showMenu(withTask task: Task, andCell cell: TaskCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    
    let status = TaskStatus(rawValue: task.status ?? "Новая")
    let alert = UIAlertController(title: "Задача", message: task.briefDescription, preferredStyle: .actionSheet)
    let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
    
    switch status {
    case .new:
      let addToWorkAction = UIAlertAction(title: "Взять в работу", style: .default) { [unowned self] _ in
        storageManager.changeStatus(task, newStatus: TaskStatus.atWork.rawValue)
        tableView.reloadRows(at: [indexPath], with: .automatic)
      }
      
      let deleteTaskAction = UIAlertAction(title: "Удалить", style: .destructive) { [unowned self] _ in
        deleteTask(withIndexPath: indexPath)
      }
      
      alert.addAction(addToWorkAction)
      alert.addAction(deleteTaskAction)
      alert.addAction(cancelAction)
    case .atWork:
      let doneAction = UIAlertAction(title: "Выполнена", style: .default) { [unowned self] _ in
        storageManager.changeStatus(task, newStatus: TaskStatus.done.rawValue)
        tableView.reloadRows(at: [indexPath], with: .automatic)
      }
      
      alert.addAction(doneAction)
      alert.addAction(cancelAction)
    default:
      break
    }
    
    present(alert, animated: true, completion: nil)
  }
}

// MARK: - TaskListDisplayLogic
extension TaskListViewController: TaskListDisplayLogic {
  func displayTasks(viewModel: TaskList.ShowTasks.ViewModel) {
    rows = viewModel.rows
    tableView.reloadData()
  }
}

