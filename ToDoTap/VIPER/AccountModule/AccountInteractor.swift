//
//  AccountInteractor.swift
//  HookahProject
//
//  Created by Nikita Kuznetsov on 23.10.2020.
//

import Foundation
import Firebase
import FirebaseFirestore

final class AccountInteractor{
    weak var presenter: AccountInteractorOutput?
    var db: Firestore!
    init() {
        
    }
}

extension AccountInteractor: AccountInteractorInput{
    func register(data: RegisterData) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { [weak self] (user, error) in
            guard let self = self else { return }
            if error != nil{
                self.presenter?.gotError(.error)
                return
            }
            if user == nil{
                self.presenter?.gotError(.userNotFound)
                return
            }
            self.db = Firestore.firestore()
            let authContext = self.formContext()
            let user = UserContext(info: UserInfo(id: 0, points: 0, name: data.fio, email: authContext.email, uId: authContext.id, phoneNumber: data.phoneNumber), history: [], orders: [])
            
            self.db.collection("users").document(authContext.id).setData(user.infoDict) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    self.presenter?.gotError(.error)
                    return
                } else {
                    print("Document added with ID: \(String(describing: authContext.id))")
                }
            }
            
            self.db.collection("users").document(authContext.id).collection("todayTask").document("Напишите задачи на день. Например: Убраться в комнате").setData(["isCheck" : false]){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                    self.presenter?.gotError(.error)
                    return
                } else {
                    print("Document added with ID: \(String(describing: authContext.id))")
                }
            }
            
            self.db.collection("users").document(authContext.id).collection("tomorrowTask").document("tomorrow").setData(["isCheck" : false]){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                    self.presenter?.gotError(.error)
                    return
                } else {
                    print("Document added with ID: \(String(describing: authContext.id))")
                }
            }
            
            self.db.collection("users").document(authContext.id).collection("weekTask").document("week").setData(["isCheck" : false]){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                    self.presenter?.gotError(.error)
                    return
                } else {
                    print("Document added with ID: \(String(describing: authContext.id))")
                }
            }
            
            self.db = nil
            self.presenter?.didSuccessAccount(context: authContext)
        }
        
    }
    
    func getVerificationID(phoneNumber: String){ 
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] (verificationID, error) in
            if error != nil {
                print(" --- \(error?.localizedDescription ?? "None") --- ")
                self?.presenter?.gotError(.error)
                return
            } else{
                UserDefaults.standard.set(verificationID, forKey: "VerificationID")
                print("VerificationID")
            }
        }
    }
    
    func checkActiveSession() {
        Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
            guard let self = self else { return }
            if user != nil
            {
                self.presenter?.didSuccessAccount(context: (self.formContext()))
            }
        })
    }
    
    func Account(type: AuthType, context: AccountData) {
        switch (type){
        case .AccountAndPassword:
            let data = context as! AccountAndPasswordData
            Auth.auth().signIn(withEmail: data.Account, password: data.password) { [weak self] (user, error) in
                guard let self = self else { return }
                if error != nil{
                    self.presenter?.gotError(.error)
                    return
                }
                if user == nil{
                    self.presenter?.gotError(.userNotFound)
                    return
                }
                self.presenter?.didSuccessAccount(context: (self.formContext()))
            }
        case .phoneNumberAndSMS:
            //let phoneData = context as! PhoneData
            
            return
        }
    }
}

private extension AccountInteractor{
    func formContext() -> AuthContext {
        let user: User = Auth.auth().currentUser!
        let context: AuthContext = AuthContext(id: user.uid, email: user.email!, type: .user)
        return context
    }
}
