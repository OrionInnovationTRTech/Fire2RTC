//
//  ContactViewController.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import UIKit

class ContactViewController: UITableViewController {
    
    private var contactListViewModel: ContactListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    private func getData() {
        ContactViewModel.fetchUsers { users in
            self.contactListViewModel = ContactListViewModel(userList: users)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func didTapUser(for user: User) {
        let storyboard =  UIStoryboard(name: "CallViewController", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController(creator: { coder -> CallViewController? in
            CallViewController (coder: coder, callViewModel: CallViewModel(user: user))
        }) else {return}
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ContactViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactListViewModel == nil ? 0 : self.contactListViewModel.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = self.contactListViewModel.userAtIndex(indexPath.row)
        let userCell = cell as? UserCell
        userCell?.didTapUser = self.didTapUser
        userCell?.selectedUser(with: user)
        return cell
    }
}
