//
//  User.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import Foundation

struct User   {
    let uid :String
    let email : String
    let password: String
    let userToken: String
    init (dictionary: [String:Any]) {
        
        self.uid = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.userToken = dictionary["userToken"] as? String ?? ""
        
    }
}
