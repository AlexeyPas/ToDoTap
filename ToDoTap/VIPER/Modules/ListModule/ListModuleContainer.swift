//
//  ListModuleContainer.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import UIKit

final class ListModuleContainer {
    let input: ListModuleModuleInput
	let viewController: UIViewController
	private(set) weak var router: ListModuleRouterInput!

	class func assemble(with context: ListModuleContext) -> ListModuleContainer {
        let router = ListModuleRouter()
        let interactor = ListModuleInteractor()
        let presenter = ListModulePresenter(router: router, interactor: interactor)
        let viewController = ListModuleViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        
        router.viewController = viewController

        return ListModuleContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ListModuleModuleInput, router: ListModuleRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ListModuleContext {
	weak var moduleOutput: ListModuleModuleOutput?
}
//
////
////  ListModuleRouter.swift
////  ToDoTap
////
////  Created by Pasynkov Alexey on 08.06.2021.
////
////
//
//import UIKit
//
//final class ListModuleRouter {
//    var viewController: UIViewController?
////    private let firstStepTF = UITextField()
////    private let stackView = ScrollableStackView(config: .defaultVertical)
////    private let chooseItemFirst = ["Сегодня", "Завтра", "Неделя"]
////    var selectedElements: String?
//
//
//}
//
//extension ListModuleRouter: ListModuleRouterInput {
//    func showAddTask(complition: @escaping (String) -> Void) {
////
////        let elemPickerfirst = UIPickerView()
////        elemPickerfirst.delegate = self
////        firstStepTF.inputView = elemPickerfirst
////        elemPickerfirst.tag = 1
////
////        createToolBar(self.firstStepTF)
//
//
//        let alertController = UIAlertController(title: "Добавить задачу", message: nil, preferredStyle: .alert)
//        alertController.addTextField()
////        alertController.addTextField()
////        alertController.textFields?.description = "день"
//        alertController.addAction(UIAlertAction(title: "Добавить", style: .default) { action in
//            guard let text = alertController.textFields?.first?.text else {
//                fatalError("alert")
//            }
//
//                complition(text)
//
//        })
//
//        viewController?.present(alertController, animated: true)
//    }
//}
////
////extension ListModuleRouter:  UIPickerViewDataSource, UIPickerViewDelegate {
////    func numberOfComponents(in pickerView: UIPickerView) -> Int {
////        return 1
////    }
////
////    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
////        switch pickerView.tag {
////        case 1:
////            return chooseItemFirst.count
////        default:
////            return 0
////        }
////    }
////
////    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
////        switch pickerView.tag {
////        case 1:
////            return chooseItemFirst[row]
////
////        default:
////            return "0"
////        }
////    }
////
////    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
////
////        switch pickerView.tag {
////        case 1:
////            selectedElements = chooseItemFirst[row]
////            self.firstStepTF.text = selectedElements
////        default:
////            return
////        }
////    }
////
////
////}
////
////extension ListModuleRouter {
////    func createToolBar(_ textField : UITextField){
////        // ToolBar
////        let toolBar = UIToolbar()
////        toolBar.barStyle = .default
////        toolBar.isTranslucent = true
////        toolBar.tintColor = .black
////        toolBar.sizeToFit()
////
////        // Adding Button ToolBar
////        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ListModuleRouter.doneClick))
////        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//////        let nextButton = UIBarButtonItem(title: "next", style: .plain, target: nil, action: #selector(ListModuleRouter.nextClick))
////        toolBar.setItems([spaceButton, doneButton], animated: false)
////        toolBar.isUserInteractionEnabled = true
////        textField.inputAccessoryView = toolBar
////    }
//
//    @objc
//    func doneClick() {
//        firstStepTF.resignFirstResponder()
//    }
//}
//
//
//extension ListModuleRouter {
//    func kbShowHide(){
//        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardWillHideNotification , object: nil)
//    }
//    @objc func kbDidShow(notification: Notification){
//        guard let userInfo = notification.userInfo else {return}
//        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        //        (self.stackView.scrollView).contentSize = CGSize(width: self.stackView.contentView.bounds.size.width, height: self.stackView.contentView.bounds.size.height + kbFrameSize.height)
//        (self.stackView.scrollView).contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0.0)
//
//        (self.stackView.scrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
//    }
//
//    @objc func kbDidHide(){
//        //        (self.stackView.scrollView).contentSize = CGSize(width: self.stackView.bounds.size.width, height: self.stackView.bounds.size.height)
//        (self.stackView.scrollView).contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//}

