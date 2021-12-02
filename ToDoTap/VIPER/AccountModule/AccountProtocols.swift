//
//  AccountProtocols.swift
//  HookahProject
//
//  Created by Nikita Kuznetsov on 19.10.2020.
//

import Foundation

protocol AccountViewInput: class{
    func showError(message: String)
}

protocol AccountViewOutput : class{
    func onClose()
    func onSkip()
    func Account(data: AccountData)
    func register()
    func checkSession()
}

protocol AccountModuleInput{
    
}

protocol AccountModuleOutput: class{
    func AccountByPhone(context: AuthContext)
    func AccountBySkip()
}

protocol AccountInteractorInput{
    func Account(type: AuthType, context: AccountData)
    func register (data: RegisterData)
    func checkActiveSession()
    func getVerificationID(phoneNumber: String)
}

protocol AccountInteractorOutput: class{
    func gotError(_ error: ErrorType)
    func didSuccessAccount(context: AuthContext)
    func didSuccessCaptcha(phoneNumber: String)
}

protocol AccountRouterInput{
//    func assembleConfirmModule(_ phoneNumber: String,  _ module:ConfirmModuleOutput)
    func assembleRegisterModule()
}

protocol AccountRouterOutput: class{
    func registerUser(data: RegisterData)
}
