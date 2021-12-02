//
//  AccountProtocols.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 10.06.2021.
//  
//

import UIKit

protocol AccountModuleInput: class {
//	var moduleOutput: AccountModuleOutput? { get }
}

protocol AccountModuleOutput: class {
    func signOut()
}

protocol AccountViewInput: class {
}

protocol AccountViewOutput: class {
    func onLogoutTapped()
}

protocol AccountInteractorInput: class {
    func logout()
}

protocol AccountInteractorOutput: class {
    func userSignedOut()
}

protocol AccountRouterInput: class {
}

protocol UserProfileRouterOutput: class {
}
