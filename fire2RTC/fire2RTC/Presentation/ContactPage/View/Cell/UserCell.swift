//
//  UserCell.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var nameTextField: UILabel!
    var didTapUser: ((User) -> Void)?
    var user: User?
    
    func selectedUser(with user: User) {
        self.user = user
        nameTextField.text = user.email
    }

    @IBAction func selectPressed(_ sender: UIButton) {
        guard let unwrappedUser = user else { return }
        didTapUser?(unwrappedUser)
    }
}
