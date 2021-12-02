//
//  TomorrowContainer.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import UIKit

final class TomorrowContainer {
    let input: TomorrowModuleInput
	let viewController: UIViewController
	private(set) weak var router: TomorrowRouterInput!

	class func assemble(with context: TomorrowContext) -> TomorrowContainer {
        let router = TomorrowRouter()
        let interactor = TomorrowInteractor()
        let presenter = TomorrowPresenter(router: router, interactor: interactor)
		let viewController = TomorrowViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        
        router.viewController = viewController

        return TomorrowContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: TomorrowModuleInput, router: TomorrowRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct TomorrowContext {
	weak var moduleOutput: TomorrowModuleOutput?
}
