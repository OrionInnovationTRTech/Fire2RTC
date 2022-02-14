//
//  ContactViewModel.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import Foundation
import Firebase

struct ContactViewModel {
    
    let userSelected : User
    
    init(_ user: User) {
        self.userSelected = user
    }
    
    var name: String {
        return self.userSelected.email
    }
    
    static func fetchUsers(completion: @escaping ([User]) -> Void ){
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            
            snapshot?.documents.forEach({ document in
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
                
            })
        }
    }
}

struct ContactListViewModel {
    
    let userList : [User]
    
    func numberOfRowsInSection() -> Int {
        return self.userList.count
    }
    
    func userAtIndex(_ index: Int) -> User {
        let user = self.userList[index]
        return user
    }
}
