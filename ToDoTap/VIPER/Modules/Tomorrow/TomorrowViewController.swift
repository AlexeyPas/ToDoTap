//
//  TomorrowViewController.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import UIKit
import PinLayout
import Firebase

final class TomorrowViewController: UIViewController {
    private let output: TomorrowViewOutput
    private let tableView = UITableView()
    
    
    private var tomorrowTasks = [TaskViewModel]()
    
    
    init(output: TomorrowViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view  = UIView()
        view.addSubview(self.tableView)
        setupTableView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "backWindow"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.didTapAddTaskButton))
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.pin.all()
    }
    
    @objc
    private func didTapAddTaskButton() {
        self.output.didTapAddTaskButton()
        if (!tomorrowTasks.isEmpty) {
            if (self.tomorrowTasks[0].task == "Нажмите на + в правом верхнем углу, чтобы добавить задачу")  {
                self.tomorrowTasks.remove(at: 0)
                self.output.deliteDate(task: "Нажмите на + в правом верхнем углу, чтобы добавить задачу")
            } else if (self.tomorrowTasks[0].task == "Напишите задачи на завтра. Например: Помыть машину")  {
                self.tomorrowTasks.remove(at: 0)
                self.output.deliteDate(task: "Напишите задачи на завтра. Например: Помыть машину")
            }
        }
    }
    
}

extension TomorrowViewController: TomorrowViewInput {
    func set(viewModels: [TaskViewModel]) {
        self.tomorrowTasks = viewModels
        self.tableView.reloadData()
    }
    
    func add(newTask: String) {
        
        self.tomorrowTasks.append(TaskViewModel(task: newTask, isCheck: false))
        self.output.loadDate(task: newTask)
        self.tableView.reloadData()
        
    }
}


extension TomorrowViewController: UITableViewDataSource, UITableViewDelegate {

    func changeState(at item: Int) -> Bool {
        tomorrowTasks[item].isCheck = !tomorrowTasks[item].isCheck
        self.output.updateDate(task: tomorrowTasks[item].task, isCheck : tomorrowTasks[item].isCheck)
        return tomorrowTasks[item].isCheck
    }
    
    private func removeItem(at index: Int) {
        if tomorrowTasks.count == 1 {
            let newElem = TaskViewModel(task: "Нажмите на + в правом верхнем углу, чтобы добавить задачу", isCheck: false)
            tomorrowTasks.append(newElem)
            self.output.loadDate(task: "Нажмите на + в правом верхнем углу, чтобы добавить задачу")
            self.output.deliteDate(task: tomorrowTasks[index].task)
            tomorrowTasks.remove(at: index)
        } else {
            self.output.deliteDate(task: tomorrowTasks[index].task)
            tomorrowTasks.remove(at: index)
        }
        //        deleteDataFromFB(at: index)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tomorrowTasks.count
    }
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
        
        cell.configure(textFromDB: self.tomorrowTasks[indexPath.row].task)
        if self.tomorrowTasks[indexPath.row].isCheck {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if tomorrowTasks.count == 1 {
                self.output.loadDate(task: "Нажмите на + в правом верхнем углу, чтобы добавить задачу")
                add(newTask: "Нажмите на + в правом верхнем углу, чтобы добавить задачу")
                self.output.deliteDate(task: tomorrowTasks[indexPath.row].task)
                tomorrowTasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                self.output.deliteDate(task: tomorrowTasks[indexPath.row].task)
                tomorrowTasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {
            
        }
    }
    
}

private extension TomorrowViewController {
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
    }
}
