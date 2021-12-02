//
//  ListModuleViewController.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import UIKit
import PinLayout
import Firebase

final class ListModuleViewController: UIViewController {
    private let output: ListModuleViewOutput
    private let tableView = UITableView()
    
    private var todayTasks = [TaskViewModel]()
    //    private var tomorrowTasks = [TaskViewModel]()
    //    private var weekTasks = [TaskViewModel]()
    
    //    var flag = Bool()
    //    var reloadDay = String()
    //    var flagEndUpdate = Bool()
    
    init(output: ListModuleViewOutput) {
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
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapAddExitButton))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.pin.all()
    }
    
    @objc
    private func didTapAddTaskButton() {
        self.output.didTapAddTaskButton()
        if (!todayTasks.isEmpty) {
            if (self.todayTasks[0].task == "Нажмите на + в правом верхнем углу, чтобы добавить задачу")  {
                self.todayTasks.remove(at: 0)
                self.output.deliteDate(task: "Нажмите на + в правом верхнем углу, чтобы добавить задачу")
            } else if (self.todayTasks[0].task == "Напишите задачи на сегодня. Например: Убраться в комнате")  {
                self.todayTasks.remove(at: 0)
                self.output.deliteDate(task: "Напишите задачи на сегодня. Например: Убраться в комнате")
            }
        }
    }
    
//    @objc
//    private func didTapAddExitButton() {
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            return
//        }
//    }
}

extension ListModuleViewController: ListModuleViewInput {
    func set(viewModels: [TaskViewModel]) {
        //        switch day {
        //        case "today":
        self.todayTasks = viewModels
        //        case "tomorrow":
        //            self.tomorrowTasks = viewModels
        //        case "week":
        //            self.weekTasks = viewModels
        //        default:
        //            print("Error day")
        //        }
        self.tableView.reloadData()
    }
    
    func add(newTask: String) {
        //        print("Couunt Today-1 \(self.todayTasks.count)")
        //        print("tomorrowTasks Today-1 \(self.tomorrowTasks.count)")
        //        print("weekTasks Today-1 \(self.weekTasks.count)")
        //        flag = true
        //        if ((day == "today") || (day == "Today")) {
        ////            tableView.beginUpdates()
        ////            tableView.insertRows(at: [IndexPath(row: todayTasks.count-1, section: 0)], with: .automatic)
        self.todayTasks.append(TaskViewModel(task: newTask, isCheck: false))
        self.output.loadData(tasks: newTask)
        self.tableView.reloadData()
        //            reloadDay = "today"
        //            flagEndUpdate = true
        ////            tableView.endUpdates()
        //        } else if ((day == "tomorrow") || (day == "Tomorrow")){
        ////            tableView.beginUpdates()
        ////            tableView.insertRows(at: [IndexPath(row: todayTasks.count-1, section: 0)], with: .automatic)
        //            self.tomorrowTasks.append(TaskViewModel(task: newTask, isCheck: false))
        //            reloadDay = "tomorrow"
        ////            tableView.endUpdates()
        //
        //        } else if ((day == "week") || (day == "Week")) {
        ////            tableView.beginUpdates()
        ////            tableView.insertRows(at: [IndexPath(row: todayTasks.count-1, section: 0)], with: .automatic)
        //            self.weekTasks.append(TaskViewModel(task: newTask, isCheck: false))
        //            reloadDay = "week"
        ////            tableView.endUpdates()
        
        
        //    }
        
        
        //        print("Couunt Today-2 \(self.todayTasks.count)")
        //        print("tomorrowTasks-2 \(self.tomorrowTasks.count)")
        //        print("weekTasks-2 \(self.weekTasks.count)")
        //    self.tableView.reloadData()
    }
}


extension ListModuleViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func changeState(at item: Int) -> Bool {
        todayTasks[item].isCheck = !todayTasks[item].isCheck
        self.output.updateDate(task: todayTasks[item].task, isCheck : todayTasks[item].isCheck)
        return todayTasks[item].isCheck
    }
    
    private func removeItem(at index: Int) {
        if todayTasks.count == 1 {
            let newElem = TaskViewModel(task: "Нажмите на + в правом верхнем углу, чтобы добавить задачу", isCheck: false)
            todayTasks.append(newElem)
            self.output.loadData(tasks: "Нажмите на + в правом верхнем углу, чтобы добавить задачу")
            self.output.deliteDate(task: todayTasks[index].task)
            todayTasks.remove(at: index)
        } else {
            self.output.deliteDate(task: todayTasks[index].task)
            todayTasks.remove(at: index)
        }
        //        deleteDataFromFB(at: index)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todayTasks.count
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let headerView = UIView()
    //        headerView.backgroundColor = UIColor.lightGray
    //
    //        let headerLabel = UILabel(frame: CGRect(x: 30, y: 12, width:tableView.bounds.size.width,
    //                                                height: tableView.bounds.size.height))
    //        var nameForSection = String()
    //        switch section {
    //        case 0:
    //            nameForSection = "Today"
    //        case 1:
    //            nameForSection = "Tomorrow"
    //        case 2:
    //            nameForSection = "Week"
    //        default:
    //            nameForSection = "ERROR"
    //        }
    //
    //        headerLabel.font = UIFont(name: "Arial", size: 30)
    //        headerLabel.textColor = UIColor.black
    //        headerLabel.text = nameForSection
    //        headerLabel.sizeToFit()
    //        headerView.addSubview(headerLabel)
    //
    //        return headerView
    //
    //    }
    //
    //
    //
    //
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        //        return section == 0 ? CGFloat(88.0) : UITableView.automaticDimension
    ////        self.view.frame.height / 5
    //        return 60
    //
    //    }
    //
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        if indexPath.section == 0 {
        //            let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
        //            if todayTasks.count > indexPath.row {
        //                cell.configure(textFromDB: self.todayTasks[indexPath.row].task)
        //                return cell
        //            }
        //            return cell
        //        } else if indexPath.section == 1 {
        //            let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
        //            if tomorrowTasks.count > indexPath.row {
        //                cell.configure(textFromDB: self.tomorrowTasks[indexPath.row].task)
        //                return cell
        //            }
        //            return cell
        //        } else {
        //            let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
        //            if weekTasks.count > indexPath.row {
        //
        //                cell.configure(textFromDB: self.weekTasks[indexPath.row].task)
        //                return cell
        //            }
        //            return cell
        //        }
        //        let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
        //        if !flag {
        //        if (indexPath.section == 0) {
        let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
        
        cell.configure(textFromDB: self.todayTasks[indexPath.row].task)
        if self.todayTasks[indexPath.row].isCheck {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    //            self.tableView.reloadSections([indexPath.section], with: .automatic)
    //        } else if (indexPath.section == 1) {
    //            let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
    //
    //            cell.configure(textFromDB: self.tomorrowTasks[indexPath.row].task)
    //            return cell
    //
    //        } else if (indexPath.section == 2)  {
    //            let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
    //
    //            cell.configure(textFromDB: self.weekTasks[indexPath.row].task)
    //            return cell
    //
    //        }
    //        } else  {
    //            if (reloadDay == "today") && (flagEndUpdate == true) {
    //                let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
    //
    //                tableView.beginUpdates()
    //                tableView.insertRows(at: [IndexPath(row: todayTasks.count-1, section: 0)], with: .none)
    //                cell.configure(textFromDB: self.todayTasks[indexPath.row].task)
    //                tableView.endUpdates()
    //                flagEndUpdate = false
    //                return cell
    //
    //            } else if (reloadDay == "tomorrow") {
    //                let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
    //
    //                tableView.beginUpdates()
    //                tableView.insertRows(at: [IndexPath(row: tomorrowTasks.count-1, section: 0)], with: .automatic)
    //                cell.configure(textFromDB: self.tomorrowTasks[tomorrowTasks.count].task)
    //                tableView.endUpdates()
    //                return cell
    //
    ////                cell.configure(textFromDB: self.tomorrowTasks[indexPath.row].task)
    //            } else if (reloadDay == "week")  {
    //                let cell = self.tableView.dequeueCell(cellType: TaskTableViewCell.self, for: indexPath)
    //
    //                tableView.beginUpdates()
    //                tableView.insertRows(at: [IndexPath(row: weekTasks.count-1, section: 0)], with: .automatic)
    //                cell.configure(textFromDB: self.weekTasks[weekTasks.count].task)
    //                tableView.endUpdates()
    //                return cell
    //
    //            }
    ////            self.tableView()
    //        }
    
    //
    //        switch indexPath.section {
    //        case 0:
    //            if todayTasks.count > indexPath.row {
    //                cell.configure(textFromDB: self.todayTasks[indexPath.row].task)
    //                self.tableView.reloadSections([indexPath.section], with: .automatic)
    ////                self.tableView.reloadData()
    //
    //            }
    //        case 1:
    //            if tomorrowTasks.count > indexPath.row {
    //                cell.configure(textFromDB: self.tomorrowTasks[indexPath.row].task)
    //                self.tableView.reloadSections([indexPath.section], with: .automatic)
    ////                return cell
    //            }
    //        case 2:
    //            if weekTasks.count > indexPath.row {
    //                cell.configure(textFromDB: self.weekTasks[indexPath.row].task)
    //                self.tableView.reloadSections([indexPath.section], with: .none)
    ////                return cell
    //            }
    //        default:
    //            print("Error update tableView")
    ////        }
    //        return UITableViewCell()
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            removeItem(at: indexPath.row)
            
            if todayTasks.count == 1 {
                self.output.loadData(tasks: "Нажмите на + в правом верхнем углу, чтобы добавить задачу")
                add(newTask: "Нажмите на + в правом верхнем углу, чтобы добавить задачу")
                self.output.deliteDate(task: todayTasks[indexPath.row].task)
                todayTasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                self.output.deliteDate(task: todayTasks[indexPath.row].task)
                todayTasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            //            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
}

private extension ListModuleViewController {
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
    }
}
