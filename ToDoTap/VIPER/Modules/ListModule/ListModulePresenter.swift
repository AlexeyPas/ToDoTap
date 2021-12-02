//
//  ListModulePresenter.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import Foundation

final class ListModulePresenter {
	weak var view: ListModuleViewInput?
    weak var moduleOutput: ListModuleModuleOutput?

	private let router: ListModuleRouterInput
	private let interactor: ListModuleInteractorInput
    
    private var arrayTasks = [TaskViewModel]()

    init(router: ListModuleRouterInput, interactor: ListModuleInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension ListModulePresenter: ListModuleModuleInput {
}

extension ListModulePresenter: ListModuleViewOutput {
    func viewDidLoad() {
        self.interactor.fetchTasks()
    }
    
    func didTapAddTaskButton() {
        self.router.showAddTask { [weak self] newTask in
            self?.view?.add(newTask: newTask)
        }
    }
    
    func loadData(tasks: String) {
        self.interactor.loadDate(task: tasks)
    }
    
    func deliteDate(task: String) {
        self.interactor.deliteDate(task: task)
        
    }
    
    func updateDate(task: String, isCheck : Bool) {
        self.interactor.updateDate(task: task, isCheck: isCheck)
    }
}

extension ListModulePresenter: ListModuleInteractorOutput {
    func didLoad(tasks: [(String, [String : Any])]) {
        for taskTuple in tasks {
            var helpArray = TaskViewModel(task: "", isCheck: false)
            helpArray.task = taskTuple.0
            let taskTupleDict = taskTuple.1
            for (_, value) in taskTupleDict {
                helpArray.isCheck = value as! Bool
            }
            self.arrayTasks.append(helpArray)
        }

        //let viewModels = self.makeViewModels(tasks: self.arrayTasks)
        self.view?.set(viewModels: self.arrayTasks)
        self.arrayTasks.removeAll()
    }
    
    
    
    
}

private extension ListModulePresenter {
    func makeViewModels(tasks: [Task]) -> [TaskViewModel] {
        return tasks.map {
            TaskViewModel(task: $0.task, isCheck: false)
            
        }
    }
}
