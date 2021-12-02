//
//  AccountContainer.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 10.06.2021.
//  
//

import UIKit

final class AccountContainer {
    let input: AccountModuleInput
	let viewController: UIViewController
	private(set) weak var router: AccountRouterInput!

	class func assemble(with context: AccountContext) -> AccountContainer {
        let router = AccountRouter()
        let interactor = AccountInteractor()
        let presenter = AccountPresenter(router: router, interactor: interactor)
		let viewController = AccountViewController(output: presenter)

        interactor.output = presenter
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput


        return AccountContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: AccountModuleInput, router: AccountRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct AccountContext {
//    let info: UserInfo?
	weak var moduleOutput: AccountModuleOutput?
//    init(userInfo: UserInfo?, output: AccountModuleOutput?){
//        info = userInfo
//        moduleOutput = output
//    }
}
