//
//  AccountPresenter.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 10.06.2021.
//  
//

import Foundation

final class AccountPresenter {
	weak var view: AccountViewInput?
    weak var moduleOutput: AccountModuleOutput?

	private let router: AccountRouterInput
	private let interactor: AccountInteractorInput

    init(router: AccountRouterInput, interactor: AccountInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AccountPresenter: AccountModuleInput {
}

extension AccountPresenter: AccountViewOutput {
    func onLogoutTapped() {
        self.interactor.logout()
    }
}

extension AccountPresenter: AccountInteractorOutput {
    func userSignedOut() {
        moduleOutput?.signOut()
    }
}


//extension AccountPresenter: AccountRo {
//    
//}
