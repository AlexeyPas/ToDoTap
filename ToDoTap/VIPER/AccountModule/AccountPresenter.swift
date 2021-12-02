//
//  AccountPresenter.swift
//  HookahProject
//
//  Created by Nikita Kuznetsov on 23.10.2020.
//

import Foundation

final class AccountPresenter{
    weak var view: AccountViewInput?
    weak var moduleOutput: AccountModuleOutput?
    private let router: AccountRouterInput
    private let interactor: AccountInteractorInput
    
    init(_ router:AccountRouterInput,_ interactor:AccountInteractorInput){
        self.interactor = interactor
        self.router = router
    }
}

extension AccountPresenter: AccountModuleInput{
    
}

extension AccountPresenter: AccountViewOutput{
    func register() {
        router.assembleRegisterModule()
    }
    
    func Account(data: AccountData) {
        if data is AccountAndPasswordData{
            interactor.Account(type: .AccountAndPassword, context: data)
        }
//        else if data is PhoneData{
//            interactor.getVerificationID(phoneNumber: (data as! PhoneData).phoneNumber)
//            router.assembleConfirmModule((data as! PhoneData).phoneNumber, self)
//        }
    }
    
    func onClose() {
        /* View method */
    }
    
    func onSkip() {
        
    }
    func checkSession() {
        interactor.checkActiveSession()
    }
}

extension AccountPresenter: AccountInteractorOutput{
    func didSuccessCaptcha(phoneNumber: String) {
    }
    
    func gotError(_ error: ErrorType) {
        view?.showError(message: error.rawValue)
    }
    func didSuccessAccount(context: AuthContext) {
        moduleOutput?.AccountByPhone(context: context)
    }
}
//
//extension AccountPresenter: ConfirmModuleOutput{
//    func AccountBySMS(context: PhoneData) {
//        interactor.Account(type: .phoneNumberAndSMS, context: context)
//    }
//}

extension AccountPresenter: AccountRouterOutput{
    func registerUser(data: RegisterData){
        interactor.register(data: data)
    }
}
