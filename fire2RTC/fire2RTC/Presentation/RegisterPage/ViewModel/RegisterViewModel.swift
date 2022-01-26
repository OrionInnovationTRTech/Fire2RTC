//
//  RegisterViewModel.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import Foundation

import Foundation
import Firebase


class RegisterViewModel {
    
    var didTapRegister: (() -> Void)?
    
    func createNewUser (userEmail: String? , userPassword: String?) {
        if let email = userEmail, let password = userPassword {
        
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    print(err)
                } else {
                    //guard let userToken = self.delegate?.deviceToken else {return}
                    let data = ["email":email, "password": password] as [String : Any]
                    Firestore.firestore().collection("users").document(email).setData(data) { error in
                        if let err = error {
                            print(err)
                            return
                        }
                        print("Did create user")
                        self.didTapRegister?()

                    }
                }
            }
            
        }
    }
}
