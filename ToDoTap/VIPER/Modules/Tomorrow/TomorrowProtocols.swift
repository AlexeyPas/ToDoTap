//
//  TomorrowProtocols.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import Foundation

protocol TomorrowModuleInput: class {
	var moduleOutput: TomorrowModuleOutput? { get }
}

protocol TomorrowModuleOutput: class {
}

protocol TomorrowViewInput: class {
    func set(viewModels: [TaskViewModel])
    func add(newTask: String)
}

protocol TomorrowViewOutput: class {
    func viewDidLoad()
    func loadDate(task: String)
    func deliteDate(task: String)
    func updateDate(task: String, isCheck : Bool)
    func didTapAddTaskButton()
}

protocol TomorrowInteractorInput: class {
    func fetchTasks()
    func loadDate(task: String)
    func deliteDate(task: String)
    func updateDate(task: String, isCheck : Bool)
    func add(newTask: String)
}

protocol TomorrowInteractorOutput: class {
    func didLoad(tasks: [(String, [String : Any])])
}

protocol TomorrowRouterInput: class {
    func showAddTask(complition: @escaping (String) -> Void)
}
