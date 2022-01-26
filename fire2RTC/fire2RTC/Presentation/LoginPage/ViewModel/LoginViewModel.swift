//
//  LoginViewModel.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import Foundation
import Firebase

struct LoginViewModel {
    
    var didTapLogin: (() -> Void)?
    
    func loginUser (userEmail: String? , userPassword: String?) {
        if let email = userEmail, let password = userPassword {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    print(err)
                } else {
                    self.didTapLogin?()
                }
            }
        }
    }
}
