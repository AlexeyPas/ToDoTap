//
//  TomorrowInteractor.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//  
//

import Foundation
import Firebase
import FirebaseFirestore

final class TomorrowInteractor {
	weak var output: TomorrowInteractorOutput?
    
    private let db = Firestore.firestore()
    private var arrayDictsTasks = [(String, [String : Any])]()

    
}

extension TomorrowInteractor: TomorrowInteractorInput {
    func fetchTasks() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let docRef = self.db.collection("users").document(userID).collection("tomorrowTask")

        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("\(err)")
            } else {
                guard let querySnapshot = querySnapshot else {return }
                for document in querySnapshot.documents {
                    self.arrayDictsTasks.append((document.documentID, document.data()))
                }
            }
            self.output?.didLoad(tasks: self.arrayDictsTasks)
            self.arrayDictsTasks.removeAll()
        }
        }
    
    func loadDate(task: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let washingtonRef = db.collection("users").document(userID).collection("tomorrowTask")
        washingtonRef.document(task).setData([
            "isCheck" : false
        ])
        {   err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(userID)")
                }
            }
        }
    
    func deliteDate(task: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let washingtonRef = db.collection("users").document(userID).collection("tomorrowTask")
        washingtonRef.document(task).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
    }
    }
    
    func updateDate(task: String, isCheck : Bool) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let washingtonRef = db.collection("users").document(userID).collection("tomorrowTask")
        washingtonRef.document(task).setData(["isCheck" : isCheck]) { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
    }
    }

    
    func add(newTask: String) {
//        self.tasks.append(Task(task: newTask))
//        self.output?.didLoad(tasks: self.tasks)
    }
}
