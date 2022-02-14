//
//  MainViewModel.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import Foundation
import Firebase

struct MainViewModel {
    
    var didTapLogout: (() -> Void)?

    func logoutPressed () {
        
        do {
            try Auth.auth().signOut()
            self.didTapLogout?()
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
