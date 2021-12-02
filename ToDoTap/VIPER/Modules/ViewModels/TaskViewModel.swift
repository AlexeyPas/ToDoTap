//
//  TaskViewModel.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//

import Foundation

struct TaskViewModel: Codable {
    var task: String
    var isCheck: Bool
    
    init(task: String, isCheck: Bool) {
        self.task = task
        self.isCheck = isCheck
    }
}
