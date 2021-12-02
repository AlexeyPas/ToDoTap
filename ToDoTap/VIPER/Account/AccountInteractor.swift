//
//  AccountInteractor.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 10.06.2021.
//  
//

import Foundation
import Firebase

final class AccountInteractor {
	weak var output: AccountInteractorOutput?
}

extension AccountInteractor: AccountInteractorInput {
    func logout() {
        do{
            try Auth.auth().signOut()
//            output?.userSignedOut()
        }
        catch
        {
            print("Error is --- \(error.localizedDescription)")
            return
        }
        output?.userSignedOut()
    }
}
