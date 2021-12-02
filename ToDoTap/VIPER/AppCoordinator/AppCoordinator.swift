//
//  AppCoordinator.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class AppCoordinator {
    
    var window: UIWindow = UIWindow()
    var menuCoordinator: MenuCoordinator?
    
    func start() {
        FirebaseApp.configure()
        displayLoginModule()
    }
}
    
    extension AppCoordinator: LoginModuleOutput{
        func loginByPhone(context: AuthContext) {
            menuCoordinator = MenuCoordinator(window: window, appParent: self)
//            getPersonContext(context: context)
            menuCoordinator?.start()
        }
        func loginBySkip() {
        
        }
    }

extension AppCoordinator: MenuCoordinatorOutput{
func displayLoginModule() {
    let context = LoginContext(output: self)
    let loginContainer = LoginContainer.assemble(context: context)
    self.window.rootViewController = loginContainer.viewController
    self.window.makeKeyAndVisible()
}
}
