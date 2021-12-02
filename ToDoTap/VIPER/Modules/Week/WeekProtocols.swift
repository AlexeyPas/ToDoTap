//
//  WeekProtocols.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import Foundation

protocol WeekModuleInput: class {
	var moduleOutput: WeekModuleOutput? { get }
}

protocol WeekModuleOutput: class {
}

protocol WeekViewInput: class {
    func set(viewModels: [TaskViewModel])
    func add(newTask: String)
}

protocol WeekViewOutput: class {
    func viewDidLoad()
    func loadDate(task: String)
    func deliteDate(task: String)
    func updateDate(task: String, isCheck : Bool)
    func didTapAddTaskButton()
}

protocol WeekInteractorInput: class {
    func fetchTasks()
    func loadDate(task: String)
    func deliteDate(task: String)
    func updateDate(task: String, isCheck : Bool)
    func add(newTask: String)
}

protocol WeekInteractorOutput: class {
    func didLoad(tasks: [(String, [String : Any])])
}

protocol WeekRouterInput: class {
    func showAddTask(complition: @escaping (String) -> Void)
}
