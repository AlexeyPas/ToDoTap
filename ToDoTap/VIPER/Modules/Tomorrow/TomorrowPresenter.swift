//
//  TomorrowPresenter.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import Foundation

final class TomorrowPresenter {
	weak var view: TomorrowViewInput?
    weak var moduleOutput: TomorrowModuleOutput?

	private let router: TomorrowRouterInput
	private let interactor: TomorrowInteractorInput
    
    private var arrayTasks = [TaskViewModel]()

    init(router: TomorrowRouterInput, interactor: TomorrowInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension TomorrowPresenter: TomorrowModuleInput {
}

extension TomorrowPresenter: TomorrowViewOutput {
    func loadDate(task: String) {
        self.interactor.loadDate(task: task)

    }
    
    func viewDidLoad() {
        self.interactor.fetchTasks()
    }
    
    
    func deliteDate(task: String) {
        self.interactor.deliteDate(task: task)
        
    }
    
    func updateDate(task: String, isCheck : Bool) {
        self.interactor.updateDate(task: task, isCheck: isCheck)
    }
    
    func didTapAddTaskButton() {
        self.router.showAddTask { [weak self] newTask in
            self?.view?.add(newTask: newTask)
//            self?.interactor.add(newTask: newTask)
        }
    }
}

extension TomorrowPresenter: TomorrowInteractorOutput {
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

private extension TomorrowPresenter {
    func makeViewModels(tasks: [Task]) -> [TaskViewModel] {
        return tasks.map {
            TaskViewModel(task: $0.task, isCheck: false)
            
        }
    }
}
