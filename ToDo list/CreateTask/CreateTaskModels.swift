//
//  CreateTaskModels.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation


enum CreateTask {
  
  // MARK: - Use cases
  struct Request {
    let briefDescription: String
    let fullDescription: String
    let status: String
    let creationDate: Date
  }
}
