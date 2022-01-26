//
//  UserCellViewModel.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

struct UserCellViewModel {
    
    var name: String!
    var uid : String!
    var user : User!
    
    init(user: User) {
        self.name = user.email
        self.uid = user.uid
        self.user = user
    }
}
