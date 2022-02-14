//
//  RegisterViewController.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private var registerViewModel = RegisterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func didTapRegister() {
        
        let storyboard =  UIStoryboard(name: "MainViewController", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as MainViewController? else { return  }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        registerViewModel.didTapRegister  = self.didTapRegister
        registerViewModel.createNewUser(userEmail: emailTextField.text, userPassword: passwordTextField.text)
    }

}
