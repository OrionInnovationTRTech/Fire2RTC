//
//  CallViewModel.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import Foundation

struct CallViewModel {
    
    var name: String!
    var uid : String!
    var user : User!
    
    init(user: User) {
        self.name = user.email
        self.uid = user.uid
        self.user = user
    }
}
