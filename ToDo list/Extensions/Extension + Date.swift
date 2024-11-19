//
//  Extension + Date.swift
//  ToDo list
//
//  Created by Ilyas on 19.11.2024.
//

import Foundation

extension Date {
  var currentDate: String {
    let format = DateFormatter()
    format.timeZone = .current
    format.dateFormat = "dd.MM.yyyy HH:mm"
    
    return format.string(from: self)
  }
}
