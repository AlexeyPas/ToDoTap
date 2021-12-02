//
//  WeekContainer.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import UIKit

final class WeekContainer {
    let input: WeekModuleInput
	let viewController: UIViewController
	private(set) weak var router: WeekRouterInput!

	class func assemble(with context: WeekContext) -> WeekContainer {
        let router = WeekRouter()
        let interactor = WeekInteractor()
        let presenter = WeekPresenter(router: router, interactor: interactor)
		let viewController = WeekViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        
        router.viewController = viewController

        return WeekContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: WeekModuleInput, router: WeekRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct WeekContext {
	weak var moduleOutput: WeekModuleOutput?
}


//
//  WeekRouter.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//
//
//
//import UIKit
//
//final class WeekRouter {
//    var viewController: UIViewController?
//
//}
//
//extension WeekRouter: WeekRouterInput {
//    func showAddTask(complition: @escaping (String) -> Void) {
//
//        let alertController = UIAlertController(title: "Добавить задачу", message: nil, preferredStyle: .alert)
//        alertController.addTextField()
//        alertController.addAction(UIAlertAction(title: "Добавить", style: .default) { action in
//            guard let text = alertController.textFields?.first?.text  else {
//                fatalError("alert")
//            }
//
//                complition(text)
//
//
//        })
//
//        viewController?.present(alertController, animated: true)
//    }
//}
//
//
//
//
//
//
//
//
//
////
////  WeekViewController.swift
////  ToDoTap
////
////  Created by Pasynkov Alexey on 08.06.2021.
////
////
//
//import UIKit
//import PinLayout
//import Firebase
//
//final class WeekViewController: UIViewController {
//    private let output: WeekViewOutput
//    private let tableView = UITableView()
//
//    private var weekTasks = [TaskViewModel]()
//
//    init(output: WeekViewOutput) {
//        self.output = output
//
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func loadView() {
//        let view  = UIView()
//        view.addSubview(self.tableView)
//        setupTableView()
//        self.view = view
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.output.viewDidLoad()
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.didTapAddTaskButton))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapAddExitButton))
//
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.tableView.pin.all()
//    }
//
//    @objc
//    private func didTapAddTaskButton() {
//        self.output.didTapAddTaskButton()
//    }
//
//    @objc
//    private func didTapAddExitButton() {
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            return
//        }
//    }
//}
//
//extension WeekViewController: WeekViewInput {
//    func set(viewModels: [TaskViewModel]) {
//
//            self.weekTasks = viewModels
//
//        self.tableView.reloadData()
//    }
//
//    func add(newTask: String) {
//
//            self.weekTasks.append(TaskViewModel(task: newTask, isCheck: false))
//
//        self.tableView.reloadData()
//    }
//}
//
//
//extension WeekViewController: UITableViewDataSource, UITableViewDelegate {
//
//
//    func changeState(at item: Int) -> Bool {
//        weekTasks[item].isCheck = !weekTasks[item].isCheck
//        return weekTasks[item].isCheck
//    }
//
//    private func removeItem(at index: Int) {
//        if weekTasks.count == 1 {
//            let newElem = TaskViewModel(task: "Empty", isCheck: false)
//            weekTasks.append(newElem)
//            weekTasks.remove(at: index)
//        } else {
//            weekTasks.remove(at: index)
//        }
////        deleteDataFromFB(at: index)
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.weekTasks.count
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return self.view.frame.height / 8
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
//
//        cell.configure(textFromDB: self.weekTasks[indexPath.row].task)
//        if self.weekTasks[indexPath.row].isCheck {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
//        return cell
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if changeState(at: indexPath.row) {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            removeItem(at: indexPath.row)
//            // saveData()
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//
//        }
//    }
//
//}
//
//private extension WeekViewController {
//    func setupTableView() {
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//        self.tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
//    }
//}
