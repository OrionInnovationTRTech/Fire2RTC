//
//  MainViewController.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var mainViewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action:#selector(logout))
    }
    
    func didTapLogout() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func logout() {
        mainViewModel.didTapLogout = self.didTapLogout
        mainViewModel.logoutPressed()
    }
    
    @IBAction func contactPressed(_ sender: UIButton) {
        
        let storyboard =  UIStoryboard(name: "ContactViewController", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as ContactViewController? else { return  }
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
