//
//  AccountContainer.swift
//  HookahProject
//
//  Created by Nikita Kuznetsov on 23.10.2020.
//

import Foundation
import UIKit

final class AccountContainer{
    let input: AccountModuleInput
    let viewController: UIViewController
    
    class func assemble(context: AccountContext)-> AccountContainer{
        let router = AccountRouter()
        let interactor = AccountInteractor()
        let presenter = AccountPresenter(router, interactor)
        let viewController = AccountViewController_v(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.output
        
        interactor.presenter = presenter
        router.navigationControllerProvider = { [weak viewController] in
            return viewController
        }()
        router.presenter = presenter
        return AccountContainer(view: viewController, input: presenter)
    }
    
    private init(view: UIViewController, input: AccountModuleInput){
        self.input = input
        self.viewController = view
    }
}

struct AccountContext {
    weak var output: AccountModuleOutput?
}
