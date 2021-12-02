//
//  ListModuleProtocols.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import Foundation

protocol ListModuleModuleInput: class {
	var moduleOutput: ListModuleModuleOutput? { get }
}

protocol ListModuleModuleOutput: class {
}

protocol ListModuleViewInput: class {
    func set(viewModels: [TaskViewModel])
    func add(newTask: String)
}

protocol ListModuleViewOutput: class {
    func viewDidLoad()
    func didTapAddTaskButton()
    func loadData(tasks: String)
    func deliteDate(task: String)
    func updateDate(task: String, isCheck : Bool)
}

protocol ListModuleInteractorInput: class {
    func fetchTasks()
    func loadDate(task: String)
    func deliteDate(task: String)
    func updateDate(task: String, isCheck : Bool)
    func add(newTask: String)
}

protocol ListModuleInteractorOutput: class {
    func didLoad(tasks: [(String, [String : Any])])
    
}

protocol ListModuleRouterInput: class {
    func showAddTask(complition: @escaping (String) -> Void)
}
