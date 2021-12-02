//
//  TomorrowRouter.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import UIKit

final class TomorrowRouter {
    var viewController: UIViewController?

}

extension TomorrowRouter: TomorrowRouterInput {
    func showAddTask(complition: @escaping (String) -> Void) {

        
        let alertController = UIAlertController(title: "Добавить задачу", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "Добавить", style: .default) { action in
            guard let text = alertController.textFields?.first?.text else {
                fatalError("alert")
            }
           
                complition(text)

        })
        
        viewController?.present(alertController, animated: true)
    }
}
