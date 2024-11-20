//
//  TaskDetailsModels.swift
//  ToDo list
//
//  Created by Ilyas on 20.11.2024.
//

import Foundation

enum TaskDetails {
  
  // MARK: - User cases
  enum ShowDetails {
    struct Response {
      let briefDescription: String?
      let fullDescription: String?
      let status: String?
      let creationDate: String?
    }
    
    struct ViewModel {
      let briefDescription: String
      let fullDescription: String
      let status: String
      let creationDate: String
    }
  }
}
