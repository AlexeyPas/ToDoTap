//
//  WeekPresenter.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import Foundation

final class WeekPresenter {
	weak var view: WeekViewInput?
    weak var moduleOutput: WeekModuleOutput?

	private let router: WeekRouterInput
	private let interactor: WeekInteractorInput
    
    private var arrayTasks = [TaskViewModel]()

    init(router: WeekRouterInput, interactor: WeekInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension WeekPresenter: WeekModuleInput {
}

extension WeekPresenter: WeekViewOutput {
    func loadDate(task: String) {
        self.interactor.loadDate(task: task)

    }
    
    func viewDidLoad() {
        self.interactor.fetchTasks()
    }
    
    func didTapAddTaskButton() {
        self.router.showAddTask { [weak self] newTask in
            self?.view?.add(newTask: newTask)
//            self?.interactor.add(newTask: newTask)
        }
    }
    
    func deliteDate(task: String) {
        self.interactor.deliteDate(task: task)
        
    }
    
    func updateDate(task: String, isCheck : Bool) {
        self.interactor.updateDate(task: task, isCheck: isCheck)
    }
}

extension WeekPresenter: WeekInteractorOutput {
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

private extension WeekPresenter {
    func makeViewModels(tasks: [Task]) -> [TaskViewModel] {
        return tasks.map {
            TaskViewModel(task: $0.task, isCheck: false)
            
        }
    }
}
